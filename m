Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8172B7B6A7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 02:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfGaASL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 20:18:11 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48908 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbfGaASL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 20:18:11 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190731001807epoutp012f40742145e189386854c2bf3fb7086c~2VdOPN6aZ0648506485epoutp01D
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 00:18:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190731001807epoutp012f40742145e189386854c2bf3fb7086c~2VdOPN6aZ0648506485epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564532287;
        bh=YA0rQQn7uFtCA1rL5L6a/uZ7R7HvlbhOmEm0nlDhbi4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ocI68rG3XVfIbZW7vONUXxhT3/hOiUeEUuVPBmuCyx2X9bGU7PFldw/JwReCXFfA2
         Kwz/ZqrGPZNz5nTbIIaCN4snHXNlsKd89z+lMSC98pXuI/3PQsYbQfMLZdtwg8I4Uw
         8wiEjxtAo310dc+1tB/wcGYS65RLEGtqcdeklOcs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190731001807epcas1p117728fd1ec6365cf9a1c5ca30fcd6788~2VdN2FGEJ2896428964epcas1p1Z;
        Wed, 31 Jul 2019 00:18:07 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45yvCD01C7zMqYkg; Wed, 31 Jul
        2019 00:18:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.CB.04066.63ED04D5; Wed, 31 Jul 2019 09:17:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190731001757epcas1p13076c1198c94549817285784a116fb15~2VdE9y7Og0200902009epcas1p1J;
        Wed, 31 Jul 2019 00:17:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190731001757epsmtrp1251c5163a43a353d8262b6b2fff60d04~2VdE9GWjo1858918589epsmtrp1C;
        Wed, 31 Jul 2019 00:17:57 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-42-5d40de36bcde
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.DF.03638.53ED04D5; Wed, 31 Jul 2019 09:17:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190731001757epsmtip2db3c3e90afb702190e5922168b6bf604~2VdE12wN20512905129epsmtip2X;
        Wed, 31 Jul 2019 00:17:57 +0000 (GMT)
Subject: Re: [PATCH v6 09/57] devfreq: Remove dev_err() usage after
 platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f59aa777-85f3-f399-1319-3b4b0cc46805@samsung.com>
Date:   Wed, 31 Jul 2019 09:21:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730181557.90391-10-swboyd@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3e3V3N1a+leRqhdqMgQfO2ZjfJMrIYJKQEEcHQi97U3Kvd
        rTdk9lKxFysjdZStmVlmhUWNxNLEjLbeT7OEsrSiKEsGErXrNfK/zznne37n9/39Dk1oaigt
        XWhxCHYLb2KocPJq++zEhOQ3acYkV38Et8vTRHH+ki8q7rGvhuIG999GXPfOeorrfN2nSKMM
        1cUPSUOr+7zKcKC5ARkGL8dkkmuLFhYIfJ5gjxMsuda8Qkt+KrNiVfbSbH1yEpvALuDmM3EW
        3iykMukZmQnLC02h4UzcRt7kDKUyeVFk5ixaaLc6HUJcgVV0pDKCLc9kW2BLFHmz6LTkJ+Za
        zSlsUtJcfUiYU1Twc58b2YLqzS+rr1DFaPf4chRGA54HgUCjohyF0xp8DcHDIR+Sgx8I2l23
        RoMhBH+edJH/Wu6f8CvlQguCobLzpBx8Q7Bn+AZVjmh6Ml4Dz3bHSw2ROB3ag15K0hDYi+BI
        iR9JBQrHQ2v/C0riiXg6PA2+G8mr8SI4/dWtlJjEM6HFNaiSOCp05o/edqWsmQRdx9+P3CgM
        p0BNcJiQmMDR8Or9CYXMsbDrSjUhDQb8joKKQOWohXTwvn5AyTwZPnU2q2TWwsDBvaO8Dc52
        3abk5lIEza0PlHJBB61el0JySeDZ0OSbI6enw/VhN5IHT4CvvyqUkgSwGkr3amTJDHjc26OQ
        eSp49pVRhxBTNcZO1RgLVWMsVP0fdhKRDWiKYBPN+YLI2nRjv/syGtnM+PnX0MVARhvCNGIi
        1HeMaUaNkt8objG3IaAJJlLtiV5s1Kjz+C1bBbs12+40CWIb0ode+zChjcq1hvbc4shm9XN1
        Oh03j03WsywTra4NckYNzucdQpEg2AT7vz4FHaYtRrXR6yLO5Fy/X2aIurup/nOH72OUoeVU
        wKbKyp3ljl08rlLnXPP8orq4u6PC7wqP2RzpTit0gD9nw73y9b4Ub722J0torPNMO+f5kDV1
        oA8vuzDxbaWT/L2+qX98Y0X3o+SBkpXpHy/x1tV36pq+/97hUw5/2z7t6M1bjmOlfaeWAEOK
        BTwbT9hF/i+/IkxNrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXtf0nkOswc6NWhbNi9ezWZxtesNu
        cXnXHDaLz71HGC1uN65gszh+5ymTA5vH7IaLLB77565h9+jbsorR4/MmuQCWKC6blNSczLLU
        In27BK6ML+1zGQt+8FbcnL2VrYGxhbuLkZNDQsBE4vz8s6xdjFwcQgK7GSX2/n7FCpGQlJh2
        8ShzFyMHkC0scfhwMUTNW0aJrz+PMYLEhQUiJK61aIGUiwi4SBz+sZQNpIZZYCmjxJnzi6CG
        7mGUWDj3ISNIFZuAlsT+FzfYQGx+AUWJqz8eg8V5BewklrybC7aYRUBVYu/kz+wgtijQgsM7
        ZkHVCEqcnPmEBcTmFLCSmPPjNzOIzSygLvFn3iUoW1zi1pP5TBC2vETz1tnMExiFZyFpn4Wk
        ZRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOHS2tHYwnTsQfYhTg
        YFTi4T0R6xArxJpYVlyZe4hRgoNZSYR3sbh9rBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxj
        kUIC6YklqdmpqQWpRTBZJg5OqQbGIEH+Uy+U2A5vEYqSfPONh5l9+3p7J5M3jAwVxo2SV5gb
        tiqqKFWfYZm7rPeee9j1nZ/3ViRmLuE/cLehLELuX8g+zRnR6z6zeempnYjnaJA5/2eHqsaL
        36+yDH9yXMlRW8+4X8vlR0aGdv651OPXkrNbTsSwT9A9f1CUnXXx5x5NYaPdX3YosRRnJBpq
        MRcVJwIA5ambi5kCAAA=
X-CMS-MailID: 20190731001757epcas1p13076c1198c94549817285784a116fb15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190730181610epcas1p4efb84a1b5cfbb6dea0b59936e8ae1ab3
References: <20190730181557.90391-1-swboyd@chromium.org>
        <CGME20190730181610epcas1p4efb84a1b5cfbb6dea0b59936e8ae1ab3@epcas1p4.samsung.com>
        <20190730181557.90391-10-swboyd@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 31. 오전 3:15, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/devfreq/tegra-devfreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 35c38aad8b4f..ffd17aba7533 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -674,10 +674,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
