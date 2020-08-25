Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EF12513FB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHYIQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 04:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYIQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 04:16:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C503C061574
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 01:16:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nv17so840919pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4mBxqIdxfkLhY8dbHb2mAezOdwymjj8Y4qldp2QzK8k=;
        b=IobyTMBhDxUyb2xLkbmgbUenk0/HVFFtTy18WLfjWX5f0vJYloelts+oqw5wPzMMAM
         GN7/qx3aWYpXknWUbYrqdVmdO6vGt5WuwQW79wJGU6aZwJtaWEtJBa8fffTT4pxfJ3rm
         zXZdB+FFK+lsQ/jYi4KV27E6fInAjSS7WMzhzAgbWbfD4b43XGbZufSjr3OJ/dXn4iWU
         2TuxRMeLwXw5LCf0G7SO/2MoO3fUzCaThvvk0p08ugfC1KgShM6BPivVV5ejMl+co0tN
         0PedZsrAD52I5R2GvOuGnuFUa92tQPVH7hRI2XydtD4Wl+0jRRutJxfduNXUVlUjMGnl
         7IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4mBxqIdxfkLhY8dbHb2mAezOdwymjj8Y4qldp2QzK8k=;
        b=ZDWh8uB3LxLL6JFAtN2aU7A1Qd6zZbkszNCqYtVDGN9A/HJwZDdxu1j1yvTmqnoOeI
         Fx2lrJuxhfk5Onn724JfuYzS0CT0Ir0nyHVjrUwq8ikVzwQTRnmYtwdms3uLI3XN7Kh5
         w1L+jrOhhsedtCuCDBmLLVox00ZccTjKwj/dA+TRLv1KCcwYuqyNZhoxGVzd5Z7JG9vj
         XvdylNl4Buu06GPfEjuFZeC7eA54Ul1iUkUAUyubi8Gprd/ZoVPFaa6RjcgtMZTd0pcU
         lSxiigSN0qPxKpAG6VNSK/VUFucDOM0m/aY0k3zrsYKLpRBNyWKfUtS3NNzQ4xwJV0oX
         ogtQ==
X-Gm-Message-State: AOAM530JjsAdtPWh2HJgAZOdyoXofv3gDifPPL05R5Y5t6vaUEQNSEtN
        0JEZhZ7U5/WNCuqOS/MoUVRMSw==
X-Google-Smtp-Source: ABdhPJwLk+MGDicSf1tyuPkBpARnPc+hdMSYuvZzgH3KlOFtGynSK6c9RCWkDisG7+p+rXPo+ot3OQ==
X-Received: by 2002:a17:90a:f2d7:: with SMTP id gt23mr707131pjb.0.1598343400041;
        Tue, 25 Aug 2020 01:16:40 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id mw8sm1801732pjb.47.2020.08.25.01.16.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 01:16:39 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:46:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: opp: How to use multiple opp-supported-hw versions properly?
Message-ID: <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
References: <20200825074452.GA1322@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825074452.GA1322@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-08-20, 09:44, Stephan Gerhold wrote:
> Hi Viresh,
> 
> (an unrelated questions while I investigate the device links ;) )
> 
> I'm a bit confused about how to use "opp-supported-hw" properly
> when you have multiple versions defined.

Documentation/devicetree/bindings/opp/opp.txt gives some explanation which I
thought should be enough, maybe it isn't :(

Or maybe I am oversimplifying your problem and I myself have forgotten this
property and its usage :)

> In my case I have two version numbers from 0-7, so theoretically up to
> 64 versions. This does not fit into a single version mask

I don't think this is correct. The opp-supported-hw property must be thought of
as a bitfield where each bit represents a version.

In your case a single 32 bit value should be enough IMO.

<0x00FF00FF>, here each FF can support upto 8 versions, which is exactly what
you need. Now if you want to support version 3-3 (where version are numbered
from 0-7) for an OPP, you set this value to: <0x00080008>

Does that make sense ?

> so I added
> them as separate versions to the OPP table.
> 
> Now let's say I want to limit an OPP to v0.1, v1.0 and v1.1, but not
> v0.0. With a single "opp-supported-hw" I think I can only say:
> 
> 	opp-supported-hw = <0x3 0x3>;
> 
> but that does also include v0.0...
> I think to exclude that I would need multiple version ranges, e.g.
> 
> 	opp-supported-hw = <0x1 0x2>, <0x2 0x3>;
> 
> This does not seem to be supported, though.
> 
> I believe a similar situation exists in tegra20-cpu-opp.dtsi:

Dmitry, can you please explain why you were required to have multiple entries
for each OPP ?

-- 
viresh
