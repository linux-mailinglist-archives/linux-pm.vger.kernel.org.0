Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41959462
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 08:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF1Gst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 02:48:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:55725 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF1Gss (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 02:48:48 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190628064845epoutp04369fe66d390bd51caaf5db2f7be5d75a~sSf3jBMjk0793007930epoutp04V
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2019 06:48:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190628064845epoutp04369fe66d390bd51caaf5db2f7be5d75a~sSf3jBMjk0793007930epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561704525;
        bh=vNzSpyCeiJD8tnYdLvYVnJzOtUmTDCs0azG1DiRFc54=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=N9FmcEUfMCCZUPPme6SNazaV8BEEvOrV7QCJsuY3Jo7oVebnE7hye7EN59A9YLKKQ
         sGbzsNWE6YhWvXr3+7EtoEP1W2i0xyLwB+k20lCfqnTttR96KzOGjklzX+ivrOqUx1
         9ZOdpN+5lrhXAHtGaAx2bhXSpeoOONElwiY/PQg8=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190628064842epcas1p36f9028705a15def52fd754ed95356758~sSf05fDJ82626126261epcas1p3y;
        Fri, 28 Jun 2019 06:48:42 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-8f-5d15b84aba39
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.4A.04143.A48B51D5; Fri, 28 Jun 2019 15:48:42 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 02/22] PM / devfreq: tegra30: Keep interrupt disabled
 while governor is stopped
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190627211115.21138-3-digetx@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190628064842epcms1p37e66e5fa52885ef7461b439bd336e60f@epcms1p3>
Date:   Fri, 28 Jun 2019 15:48:42 +0900
X-CMS-MailID: 20190628064842epcms1p37e66e5fa52885ef7461b439bd336e60f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmnq7XDtFYg54GTYuXhzQtrn95zmqx
        +uNjRouWWYtYLM42vWG3uLxrDpvF594jjBadX2axWfzcNY/Fom/tJTYHLo8dd5cweuycdZfd
        o7f5HZtH35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl
        5qbaKrn4BOi6ZeYAHaWkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0u
        zUvXS87PtTI0MDAyBSpMyM748vACe8EPjoqp3++wNDDuZ+9i5OCQEDCRODibrYuRi0NIYAej
        xKl9TWBxXgFBib87hLsYOTmEBTIk7v+9zAxiCwkoSTTc3McMEdeX6HiwjRHEZhPQldi64S4L
        yBwRgd+MEnt3PmYFcZgFdjJKvNtynx2kSkKAV2JG+1MWCFtaYvvyrWDdnAJmEnfOXGGCiItK
        3Fz9lh3Gfn9sPiOELSLReu8sM4QtKPHg525GmDkzpvyHmlktcW36YnaQxRICLYwSvaunQBXp
        S5yZe5INxOYV8JWYcnY12DIWAVWJC/s2s0HUuEh8bv0GFmcWkJfY/nYOMygkmAU0Jdbv0oco
        UZTY+XsuI8wvDRt/s6OzmQX4JN597WGFie+Y9wTqLzWJQ7uXQNXLSJyevpB5AqPSLERYz0Ky
        eBbC4gWMzKsYxVILinPTU4sNC4yRY3cTIziBapnvYNxwzucQowAHoxIPr8JOkVgh1sSy4src
        Q4wSHMxKIryS54BCvCmJlVWpRfnxRaU5qcWHGE2B/p/ILCWanA9M7nkl8YamRsbGxhYmhmam
        hoZK4rzx3DdjhATSE0tSs1NTC1KLYPqYODilGhjjY36E6kjyTeL1EnyYxrdaQm8mR31Dyb1j
        cSeOOIjscVBxYv0yu2HHl1c3dy14bvSXgX1pz53GWWKOvReeumS+muUkl+D+57Cm0Yv4Rx+d
        +hedd3Yu25i5Kda61eHrtp6aAwnv2NbHaFu3LNitHL/13TfBxdXLlfJ5A69u7/lWsGv38o47
        fR1KLMUZiYZazEXFiQAgylkstgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190627211230epcas5p2504c225e67a823a586768a2749248b72
References: <20190627211115.21138-3-digetx@gmail.com>
        <20190627211115.21138-1-digetx@gmail.com>
        <CGME20190627211230epcas5p2504c225e67a823a586768a2749248b72@epcms1p3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>There is no real need to keep interrupt always-enabled, will be nicer
>to keep it disabled while governor is inactive.
>
>Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>---
> drivers/devfreq/tegra30-devfreq.c | 43 ++++++++++++++++---------------
> 1 file changed, 22 insertions(+), 21 deletions(-)
>
>diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>index a27300f40b0b..5e2b133babdd 100644
>--- a/drivers/devfreq/tegra30-devfreq.c
>+++ b/drivers/devfreq/tegra30-devfreq.c
[]
>@@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
> {
> 	unsigned int i;
> 
>-	disable_irq(tegra->irq);
>-
> 	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
> 		      ACTMON_GLB_PERIOD_CTRL);
> 

I think this has nothing to do with
"keep it disabled while governor is inactive."

And this looks dangerous because it disables the safety measure
of disabling interrupt while you touch some looking-critical registers.
Anyway, as I do not know the internals of Tegra SoC, I cannot sure.

Cheers,
MyungJoo


