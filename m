Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E975033E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 09:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFXHYv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 03:24:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53533 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfFXHYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 03:24:38 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190624072436epoutp04e853d5724a76043cb66e030bfe7b90c7~rEaBRVaNY2379523795epoutp04v
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 07:24:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190624072436epoutp04e853d5724a76043cb66e030bfe7b90c7~rEaBRVaNY2379523795epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561361076;
        bh=sfJqtBX9G/sO3fhboGEG/nUCWVvQPDLwTtj0etWtVMs=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=RMr0F9U3JacSzMwWNMhlP8fP2vOiuMfDy3yKnHYYpAy9Cny09EvewA3UYMk4y/oQ0
         53VvZM9cPZhes6Jsr/TeEIHjdOOXk+ELt6LMOfiuz9nzAurEIahfcK9w3subInSnIE
         lOxI6Hqt7f7B5+Spq3nvG3et/7v05IU1fNYvLATs=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190624072432epcas1p20c3fab8908c892aae51ec1040def99b6~rEZ9fFLWk1982319823epcas1p2X;
        Mon, 24 Jun 2019 07:24:32 +0000 (GMT)
X-AuditID: b6c32a36-14a859c00000102e-63-5d107aaf7c8f
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.37.04142.FAA701D5; Mon, 24 Jun 2019 16:24:31 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v4 16/16] PM / devfreq: Introduce driver for NVIDIA
 Tegra20
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "digetx@gmail.com" <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190624072431epcms1p3bdfd41545e7daecb1f6472c1e6f9dcfc@epcms1p3>
Date:   Mon, 24 Jun 2019 16:24:31 +0900
X-CMS-MailID: 20190624072431epcms1p3bdfd41545e7daecb1f6472c1e6f9dcfc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA12Se0hTYRjG+XaOZ0dt9Tkvfc2l61TCDJ1HnR4jI8hipJEh/hOuedDDtF3Z
        2aILwSC7iY4iQZtp3iJIygte1oWgFZGVGVGJkCZdmaUWq0iky64o/ffj4Xnf93nf7yMxsYOQ
        kNVGK2cxsnqKiMKH7snT03qOQHXGrCOT8bjlzPj3TxFM97d3gKlxduCMt/4+YM58dxLMws1W
        fJtQdcM5KVTVH58jVI6Bq0Dl7U8qxvfptlRxbCVnkXHGClNltVGbTxWWaLZrlDkZdBqdx+RS
        MiNr4PKpgqLitJ3Vel8ASnaQ1dt8UjHL85Ri6xaLyWblZFUm3ppPceZKvTnPnM6zBt5m1KZX
        mAyb6YyMTKXPWK6rqhn/KzB/iTr0yjlJ2MFLshZEkghmo5+Nz/FaEEWKoQsgT4dDWAtIUgRj
        0G9XrN8TC/eioddTuJ/FkEL2iTtYUFeg09NDwM8ETEODvZOBPnGwT4Caxt4QwQEi1HTqAx7k
        RDR8ZRAEOR5NdM8Kwzz/4FJIj0MnpkaxIMeg6YVbIFzb1PA31OcoetXYKfQPQ7AGoPruhpBJ
        gZ60jAQGi+Bu5HA9E/gZhxtR+9jPwGIIFqDnUwE7BpPR8OxFzC9jUI56biqCXdahG4stIBzf
        3rco/J8xuBLN/aiLCOuu1veCIKcg962ukF+KHje2h1ZRoR8LM0TwhnuRc+QidhbInEuXdi4L
        5FwK1AawqyCBM/MGLcfT5szlj9sPAn8xNccFOp4WuQEkAbVCBHtXqcUR7EH+sMENEIlRcaLL
        LFSLRZXs4SOcxaSx2PQc7wZK31nOYZL4CpPvZxutGlqZmZWVxWTTOUqaplaLNNETZWKoZa2c
        juPMnCVcJyAjJXZQWp4w2hlhKNyUuqOUirWWvv8q6tK1DRdEvd0loUcUZZ49t+uK1ssj+98Z
        75Rcf7ihOPpjQ9LQtWhvXUuJJzuXS5SWzaiT+TOPmtfb/+woHP/864L4bIp30VUild6+u1bz
        YuHA/Jprm9aQ+1Xnm4dfdw40efYf8+QS3qIa+uTIRymF81UsnYpZePYf2TOFPKEDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190624072431epcms1p3bdfd41545e7daecb1f6472c1e6f9dcfc
References: <CGME20190624072431epcms1p3bdfd41545e7daecb1f6472c1e6f9dcfc@epcms1p3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
> reads out Memory Controller counters and adjusts memory frequency based
> on the memory clients activity.
> 
> Reviewed-by: Chanwoo Choi 
> Signed-off-by: Dmitry Osipenko 

Could you please send a separate commit for MAINTAINERS?

I can add Ack to it, but I don't feel comfortable with sending
a pull-request with MAINTAINERS entry updates.

Cheers,
MyungJoo

> ---
>  MAINTAINERS                       |   8 ++
>  drivers/devfreq/Kconfig           |  10 ++
>  drivers/devfreq/Makefile          |   1 +
>  drivers/devfreq/tegra20-devfreq.c | 212 ++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+)
>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98edc38bfd7b..e7e434f74038 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10098,6 +10098,14 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
>  
> +MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
> +M:	Dmitry Osipenko 
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
>  W:	http://www.linux-mm.org
