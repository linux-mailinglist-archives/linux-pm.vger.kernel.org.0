Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00B22514B4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgHYI5t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 04:57:49 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:23214 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgHYI5t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 04:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598345866;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=lC83DjmLOBHgJU8+9zEoBSzON5ADdijXCUJWFjompmo=;
        b=emssEqPmEwVLPSLYQkRry+KI3p1Dzginvqgm4WuKY5VOenLO8xbvcLG9OY0DB3dnpf
        zS4vdFYw8mP5goreAID4ACrjokMbvkcCm/u6yAK4m+nE45IWUK6zJu67hD9F2ALbnRMj
        qR4pCvczXYAcdutHjNhnm8SDYJAczJVlGEuYYn6MBIUKDvdnFs4PWqmWHYPXroyDbSNT
        DWiqbDQmcHVx2mGrQLszg3IXdLyKvA6L6tTFnCBEsEvj0m4gTI3O2jp1QSQobkKkn+91
        nVJyqOZWB8jhCge1iXm0k3ULydc92q/3M+AErw8cLN53QTG2gHASg5ZRgh8/5kOOT+qf
        aRFQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IcjDBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7P8vjdNu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 25 Aug 2020 10:57:45 +0200 (CEST)
Date:   Tue, 25 Aug 2020 10:57:40 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: opp: How to use multiple opp-supported-hw versions properly?
Message-ID: <20200825085740.GA855@gerhold.net>
References: <20200825074452.GA1322@gerhold.net>
 <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 25, 2020 at 01:46:37PM +0530, Viresh Kumar wrote:
> On 25-08-20, 09:44, Stephan Gerhold wrote:
> > Hi Viresh,
> > 
> > (an unrelated questions while I investigate the device links ;) )
> > 
> > I'm a bit confused about how to use "opp-supported-hw" properly
> > when you have multiple versions defined.
> 
> Documentation/devicetree/bindings/opp/opp.txt gives some explanation which I
> thought should be enough, maybe it isn't :(
> 
> Or maybe I am oversimplifying your problem and I myself have forgotten this
> property and its usage :)
> 
> > In my case I have two version numbers from 0-7, so theoretically up to
> > 64 versions. This does not fit into a single version mask
> 
> I don't think this is correct. The opp-supported-hw property must be thought of
> as a bitfield where each bit represents a version.
> 
> In your case a single 32 bit value should be enough IMO.
> 

I took this from Documentation/devicetree/bindings/opp/opp.txt:

"Each level of hierarchy is represented by a 32 bit value, and so there
 can be only 32 different supported version per hierarchy. i.e. 1 bit
 per version. A value of 0xFFFFFFFF will enable the OPP for all versions
 for that hierarchy level. And a value of 0x00000000 will disable the
 OPP completely, and so we never want that to happen."

Also:

"If 32 values aren't sufficient for a version hierarchy, than that
 version hierarchy can be contained in multiple 32 bit values. i.e.
 <X Y Z1 Z2> in the above example, Z1 & Z2 refer to the version
 hierarchy Z."

but it doesn't mention anything about the problem I described
("conflicting" ranges for one of the "sub-versions").

> <0x00FF00FF>, here each FF can support upto 8 versions, which is exactly what
> you need. Now if you want to support version 3-3 (where version are numbered
> from 0-7) for an OPP, you set this value to: <0x00080008>
> 
> Does that make sense ?
> 

I have to admit that I keep getting confused with these bit masks...
I think this is also one option I considered but actually it doesn't
work:

Essentially you suggest to encode a version using:

static int ver(int version1, int version2) {
	return BIT(version1) << 16 | BIT(version2);
}

Now let's take a look at my example again:

> > Now let's say I want to limit an OPP to v0.1, v1.0 and v1.1, but not
> > v0.0. With a single "opp-supported-hw" I think I can only say:
> > 
> > 	opp-supported-hw = <0x3 0x3>;
> > 
> > but that does also include v0.0...
> > I think to exclude that I would need multiple version ranges, e.g.
> > 
> > 	opp-supported-hw = <0x1 0x2>, <0x2 0x3>;
> > 
> > This does not seem to be supported, though.
> > 

So for the versions I mentioned we get:
  - ver(0, 1) = 0x10002
  - ver(1, 0) = 0x20001
  - ver(1, 1) = 0x20002
  - ver(0, 0) = 0x10001 (this one should be excluded)

So to mark v0.1, v1.0 and v1.1 as supported I'd set:
     opp-supported-hw = <(ver(0, 1) | ver(1, 0) | ver(1, 1))>;
i.e. opp-supported-hw = <0x30003>;

Now let's say I'm running v0.0 = 0x10001. This version should not
support the OPP. But actually 0x30003 & 0x10001 = 0x10001 != 0,
so the OPP would consider it as supported.

I tried many different approaches, but you end up being unable to
control subversions independently for most of them.

But as I mentioned I keep getting really confused with these bitmasks,
so maybe I'm wrong :)

Thanks!
Stephan
