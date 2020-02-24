Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89916A7DE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBXOII (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 09:08:08 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44087 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBXOII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 09:08:08 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200224140806euoutp01cded7f968e0985241ca264acf09ac07b~2W9RZomxw1987519875euoutp01Q
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 14:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200224140806euoutp01cded7f968e0985241ca264acf09ac07b~2W9RZomxw1987519875euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582553286;
        bh=F6LcwmwJuCoUGp60qGZo5dj9ozdjL1efjDoXk9YAcWQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lDOz9L58JB0iLTsppl08OGRUtYqTQo/zb1tUiQj+nfa8VQ5NRwLbU3urVynQf1Vej
         YVx8dHJRBTO7V9p5PFmb+/JsJv3oZRYlqyHhcox7VID0346TuIqKsYaELOlJ8D/u1Y
         str3ci1AcZcdXTl0AJmjSszGw1MYIBHI/xHR4cng=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200224140806eucas1p23b445f5dcea4e466f8499d74f1ab93a6~2W9RIE53o2081120811eucas1p2A;
        Mon, 24 Feb 2020 14:08:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.E0.60698.6C8D35E5; Mon, 24
        Feb 2020 14:08:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200224140805eucas1p1559dcc94f7015c49681b560952a03376~2W9QxLT543163931639eucas1p1K;
        Mon, 24 Feb 2020 14:08:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200224140805eusmtrp1cdde73c4d19b16e15a9516bb860d799a~2W9Qwcw7p1015510155eusmtrp1I;
        Mon, 24 Feb 2020 14:08:05 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-34-5e53d8c6695d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.12.08375.5C8D35E5; Mon, 24
        Feb 2020 14:08:05 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200224140805eusmtip1d19c8436fefaeb2e96b37b27ed639535~2W9QXYJWL1698016980eusmtip1t;
        Mon, 24 Feb 2020 14:08:05 +0000 (GMT)
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible
 strings
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <61dc8192-e313-021f-9e23-928257a66984@samsung.com>
Date:   Mon, 24 Feb 2020 15:08:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221171342.GI5546@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7rHbgTHGTzeLGyxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0eJ24wo2i9a9R9gtTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKO4bFJSczLLUov07RK4Mra332IruMleceXEAdYGxslsXYycHBICJhIbv05j72Lk4hASWMEo
        seDyCkYI5wujxN3jV5khnM9AmaO/4FomLVsI1bKcUaL/z0co5y2jxJqD05lAqoQFAiQWXLvF
        CGKLCChLXP2+lwWkiFlgC5NE/8Z5YKPYBAwlut52gdm8AnYSTcffgTWzCKhK7Pk6gRXEFhWI
        lZi98jALRI2gxMmZT8BsTgEjiedzNoItYBaQl9j+dg4zhC0ucevJfCaQZRIC29glvvW8Z4a4
        20Vi1bxPUD8IS7w6voUdwpaROD25hwWioZlR4uG5tewQTg+jxOWmGYwQVdYSd86BQoADaIWm
        xPpd+hBhR4kLU84xgYQlBPgkbrwVhDiCT2LStunMEGFeiY42IYhqNYlZx9fBrT144RLzBEal
        WUhem4XknVlI3pmFsHcBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwDR0+t/xrzsY
        9/1JOsQowMGoxMMrsTc4Tog1say4MvcQowQHs5IIrzdjUJwQb0piZVVqUX58UWlOavEhRmkO
        FiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjGq61dvKg/ZtnzJP4kvV2Wkbv2aEVLCIsER9
        r47NntfpsUOucf1SvgBVwcKQP25TQ77FOr7d7ezWzSNo8rOzlcNq43H3FvXSW9I3bNOC85m0
        rF1TUtcFeUdeDunMauk/0zQvXDSnM1KYuSBF6bvfIkabkv3Gy/Ke7Hn77fkZgWeBMqGvXS4p
        sRRnJBpqMRcVJwIAIcljzD8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xu7pHbwTHGRzvt7LYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaHG7cQWbReveI+wWp3eXOHB6bFrVyebRt2UVo8fnTXIB
        zFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gdvb
        b7EV3GSvuHLiAGsD42S2LkZODgkBE4lJyxaydzFycQgJLGWUaHrawgKRkJE4Oa2BFcIWlvhz
        rYsNoug1o8TpFa2MXYwcHMICfhJrZxmA1IgIKEtc/b6XBaSGWWAbk8SlpjmMEA2fmSQa/t1i
        BqliEzCU6HrbBbaaV8BOoun4OyYQm0VAVWLP1wlg20QFYiVuzOxggqgRlDg58wnYRZwCRhLP
        52xkBLGZBcwk5m1+yAxhy0tsfzsHyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuL
        c9Nziw31ihNzi0vz0vWS83M3MQKjbtuxn5t3MF7aGHyIUYCDUYmHV2JvcJwQa2JZcWXuIUYJ
        DmYlEV5vxqA4Id6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJoS8knhDU0NzC0tDc2NzYzML
        JXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MHBc0TGQ2iKyrYfQLyZzpE6mkdeZdwoPP7Y0X
        XnlIMl6MOPjhueNaBtEEZTvnE8/6Jtk/TmLO4dryfrHhZJl/90+dOiHAfPUmm2J5wS6G/1cX
        TmnY0nDfaql8harkwoayiccU3x0v2a4TdV5jt4Cm+Ckdn/X5GoEOZ0/4z1n57lzFvv9/WU+J
        K7EUZyQaajEXFScCAJF83I7QAgAA
X-CMS-MailID: 20200224140805eucas1p1559dcc94f7015c49681b560952a03376
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
        <20200220145127.21273-1-m.szyprowski@samsung.com>
        <20200220165614.GD3926@sirena.org.uk>
        <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
        <20200221123813.GB5546@sirena.org.uk>
        <b52332cd-1dec-fdfe-51fc-8605d94abe7d@samsung.com>
        <20200221171342.GI5546@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

On 21.02.2020 18:13, Mark Brown wrote:
> On Fri, Feb 21, 2020 at 02:23:57PM +0100, Marek Szyprowski wrote:
>> On 21.02.2020 13:38, Mark Brown wrote:
>>> We could just remove the compatible strings from the binding
>>> documentation, they won't do any harm if we don't use them.
>> Frankly I have no strong opinion on this. I've just wanted to fix the
>> broken autoloading of the drivers compiled as modules.
> Shouldn't adding the relevant module table for the platform devices work
> just as well for that?  Possibly also deleting the of_compatible bits in
> the MFD as well, ISTR that's needed to make the platform device work.

Right. This will work too. MFD cells will match to their drivers by the 
name and modalias strings will be correct. The question is which 
approach is preffered? Krzysztof? I've checked other mfd drivers, but I 
cannot find any pattern in this area.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

