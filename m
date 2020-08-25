Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1472B251380
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgHYHpE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 03:45:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:16390 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgHYHpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 03:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598341501;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=ydPpo69w1B1ibSP8H5XmzBeLFvyuBUNzu4+ovucWFMo=;
        b=K7cltNQzfOKVnkBwRsfa6gXKLOrECThADt9eSpiZgvpUuEAZtW8P40w/k0ZxQ3R8TV
        xg3o3WR9E2btvZ6aLS85fDpNbRA8R9owezCkEKV3NWAmfQu3FdyNAKzjcoH+JxbVh8ZG
        JoUFTXXsKzQprHwAEGIxYivvJpSHHoWcDkH808Ma2KYNcghbqXIkU1MpKSS9kHkH0Upn
        4tX26Ny3ODoD6k/EJ6KGcte2ZpmmF7+B1WR14nkjq3JULDPHmFuJ3s9NuJZNSn4Qy0PD
        FNBaPTU1DrVl34ITG1ijLfi79mkD2mlkwLtj4L6tgfupfI8AVmEDmGx9PlQ/vRXZs6lz
        PChw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IcjDBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7P7j0csf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 25 Aug 2020 09:45:00 +0200 (CEST)
Date:   Tue, 25 Aug 2020 09:44:52 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
Subject: opp: How to use multiple opp-supported-hw versions properly?
Message-ID: <20200825074452.GA1322@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

(an unrelated questions while I investigate the device links ;) )

I'm a bit confused about how to use "opp-supported-hw" properly
when you have multiple versions defined.

In my case I have two version numbers from 0-7, so theoretically up to
64 versions. This does not fit into a single version mask so I added
them as separate versions to the OPP table.

Now let's say I want to limit an OPP to v0.1, v1.0 and v1.1, but not
v0.0. With a single "opp-supported-hw" I think I can only say:

	opp-supported-hw = <0x3 0x3>;

but that does also include v0.0...
I think to exclude that I would need multiple version ranges, e.g.

	opp-supported-hw = <0x1 0x2>, <0x2 0x3>;

This does not seem to be supported, though.

I believe a similar situation exists in tegra20-cpu-opp.dtsi:
The way it was solved there is to duplicate many of the OPP nodes
and set them with different "opp-supported-hw" properties. e.g.

	opp@1000000000,1000 {
		clock-latency-ns = <400000>;
		opp-supported-hw = <0x02 0x0006>; // v1.1 or v1.2
		opp-hz = /bits/ 64 <1000000000>;
	};

	opp@1000000000,1000,0,2 {
		clock-latency-ns = <400000>;
		opp-supported-hw = <0x01 0x0004>; // v0.2
		opp-hz = /bits/ 64 <1000000000>;
	};

I think this is supposed to say v1.1, v1.2 or v0.2, but not v0.1.

I suppose duplicating the OPP node would also work in my case, but
personally I think this just makes the OPP table unnecessarily hard
to understand - especially when there are many more properties like
interconnects, other required-opps, ...

Wouldn't it be much cleaner to allow setting multiple version ranges
for a single "opp-supported-hw" property? The above could then become:

	opp@1000000000,1000 {
		clock-latency-ns = <400000>;
		opp-supported-hw = <0x02 0x0006>, <0x01 0x004>; // v1.1, v1.2 or v0.2
		opp-hz = /bits/ 64 <1000000000>;
	};

Or is there some other option that I'm missing?

Thanks!
Stephan
