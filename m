Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058A7502A6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfFXHAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 03:00:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:12858 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfFXHAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 03:00:25 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190624070022epoutp02aeabe11809c5c27408819f7c43132b17~rEE3c496Q3140131401epoutp02Q
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 07:00:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190624070022epoutp02aeabe11809c5c27408819f7c43132b17~rEE3c496Q3140131401epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561359622;
        bh=gjOb94pyYvpO/imGBEoJBVAesPbCsDcNH0NJiUfAVno=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=gBTyaRm7fkRfIvlXNMvcOdrC5EoUcrG6XFX+qrnIJ2J1cK8E+8FzSjQKzxdWEYoIZ
         wZWnwHieo4RkEtTaPtsSpRiDsunUY2wx9uePnG9G+GMywE4yRmwZ+WHPJdAdkO/RSj
         LKLoB/ORsu3BHcpywVXwFHChJdf2wuA5CydbS9CE=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190624070011epcas1p21937d6d1c96c66e4c069cf5d2a85770a~rEEttDfw01292512925epcas1p2l;
        Mon, 24 Jun 2019 07:00:11 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-74-5d1074c7993a
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.CD.04142.7C4701D5; Mon, 24 Jun 2019 15:59:19 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "digetx@gmail.com" <digetx@gmail.com>,
        "janathanh@nvidia.com" <janathanh@nvidia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
Date:   Mon, 24 Jun 2019 15:59:19 +0900
X-CMS-MailID: 20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTV/d4iUCswbwD8hYvD2laXP/ynNVi
        9cfHjBYzpv9hsri8aw6bxefeI4wWnV9msTmwe+ycdZfdo7f5HZtH35ZVjB6fN8kFsERl22Sk
        JqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaCkUJaYUwoU
        CkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM6YcGcl
        Y8FTzorTX1ayNDA+Ye9i5OSQEDCROPRrEyuILSSwg1HiwFH1LkYODl4BQYm/O4RBwsICThLN
        Py6yQZQoSTTc3McMEdeX6HiwjRHEZhPQldi64S4LiC0i0MAosX2mQxcjFwezwE5GiXdb7kPt
        4pWY0f6UBcKWlti+fCsjhC0qcXP1W3YY+/2x+VBxEYnWe2eZIWxBiQc/dzPC9M6Y8h9qTrXE
        temL2UGWSQi0MEr0rp4CVaQvcWbuSbCreQV8JaZ2/gFrYBFQlfj47THUMheJ/c/ugtUzC8hL
        bH87hxnkeWYBTYn1u/QhShQldv6eywhzf8PG3+zobGYBPol3X3tYYeI75j1hgrDVJA7tXgJV
        LyNxevpCqF88JF6c2Mc6gVFxFiKoZyE5YhbCEQsYmVcxiqUWFOempxYbFhghR+4mRnBa1DLb
        wbjonM8hRgEORiUeXoEN/LFCrIllxZW5hxglOJiVRHiXJgrECvGmJFZWpRblxxeV5qQWH2I0
        BYbFRGYp0eR8YMrOK4k3NDUyNja2MDE0MzU0VBLnjee+GSMkkJ5YkpqdmlqQWgTTx8TBKdXA
        eDxr9sVini0/jlbFZGe9W8Bu9S/HR8j25c2zyudsLH6Kh05Tf/ElovbOFyWryY5aH312Rba1
        bz0gL/DjpFHH3Vam2H71hMWHj86f6PJrfY4Cx3Szr0ELhcNZStUMvP9yljy+/LlWuspLk5cr
        9Hr/kny9pIeXLuy+/1CFq4W94M+X0DU7jr0xVmIpzkg01GIuKk4EAIGly8ShAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f
References: <CGME20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Thu, May 02, 2019 at 02:38:12AM +0300, Dmitry Osipenko wrote:
> > The devfreq driver can be used on Tegra30 without any code change and
> > it works perfectly fine, the default Tegra124 parameters are good enough
> > for Tegra30.
> > 
> > Reviewed-by: Chanwoo Choi 
> > Signed-off-by: Dmitry Osipenko 
> > ---
> >  drivers/devfreq/Kconfig         | 4 ++--
> >  drivers/devfreq/tegra-devfreq.c | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> Acked-by: Thierry Reding 
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 7dd46d4..b291803 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -93,8 +93,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  This does not yet operate with optimal voltages.
>  
>  config ARM_TEGRA_DEVFREQ
> -	tristate "Tegra DEVFREQ Driver"
> -	depends on ARCH_TEGRA_124_SOC
> +	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> +	depends on ARCH_TEGRA
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.

A question:

Does this driver support Tegra20 as well?
I'm asking this because ARCH_TEGRA includes ARCH_TEGRA_2x_SOC
according to /drivers/soc/tegra/Kconfig.

Cheers,
MyungJoo.

