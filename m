Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8561CB728
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 20:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEHS1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 14:27:42 -0400
Received: from mout.web.de ([212.227.17.12]:48023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgEHS1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 14:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588962443;
        bh=DPe3hJBNKW8YyLJ13YIoawSHFoqrJE5EaMxdAe7CZUI=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=MjyyPjYCFmC9235O9ym3k6l4R1liyOPx4rlVN1ypY0TxW+6ksvSquuIMboQLl41lV
         95EW916vayqWdakBRlmK8dj+HO7xNiofN5RHFr1gbA4B2RJdS1Yuwe0JT/n2n9KpBA
         xhG0yxGgKQ5l0jTPBBnqPEjvkIjRq7s3UAQyQhDg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SP7-1j80KT3znr-013rEn; Fri, 08
 May 2020 20:27:23 +0200
Cc:     linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH] memory/samsung: reduce unnecessary mutex lock area
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Bernard Zhao <bernard@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Message-ID: <90c5ceac-c3dc-3811-a763-bd89173bb2c2@web.de>
Date:   Fri, 8 May 2020 20:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vQHtR5OjxbsPzPp1cxOFZQUIS05I9mIXe1SI6YlFqX98z6V7gQB
 RuV5sQQNSqiIBYt8Ya2FekNccTV5tUA+ZS37Yt7p0ZL5yn6c98NLXwgz04118v5ZlVf5JDW
 dA0YcFy+1vWMIP0sRCBiGX/2yYnFFJYc+pPr2oV68Nm3VAURR8xXlYeZ3rUR7rR+odxXxjw
 B4LYuHBUlhYH0JGGck4Uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e5hrm9ME85A=:VHfnumuUk8Q3i1mpg5ciiA
 i95lk4xAhZjeDSPF2S3jBEVejd2rgg6AXucnffhz9wzIFsmFikKELCtIsFh3Zcaze4eKRvfby
 zTUXLjJQygh7ji92FqyxAQrof9BdTOxf+sAteAstvrTbjkZ9o3dHXUWoE8nvo+gfl4N0PPU3W
 h1B1IwsUYfURypHYT0GwHckGXnVrBIH6UMsnpUnh4gGwSFSpXSEe8cCMRqCG4KKS/bOMtjdP1
 Wyh+l4OaHm7ajnO0pk0hy+OWiZRZeT4LlHn2p9JFdXRRGrCVyA+aALp9NMH5gRKjqiCz/MfPw
 K+lZnwehd040ZSfDVqrXK0aQ25GWikXEbtP4kcBqsMc3oW1cGX5MmtZTGjDUSQokgAf8CVXTG
 jozCtggbh9jekdDH38lZom6ReADAs3fo7gzx8dm7JcurmWjqrS5uU/yoEb766b85tnTt/5Jzn
 yw8MggujOfmyWewrtBm7VtPJlRHlWrbks8O7wr5wwrjpupWmDs4j1NEBFnW+4Z3V6hzwKr9XD
 eg24M27TfuWReT4j3NeEZt0c45bUTiWdue0XcqYFYICfd6Bkhw5mvc4k/ojVYH5aJo1WQhjPb
 XXMIKI41qJBrFUaRSFWMx2oSpQcWkx6o7I0UFaCS1TnYMbGiK+/mdjLKaczIlucsabeLVvUCr
 p8hDGUFZWLuIBJeXNQ6y86+XB3fYuXvPFOOpCpWn+TsMfvIXnheqITBOnaPr2XLkKDqVP2WjM
 qXnus2TEKnfZDngnDZX5EsQUOw+eTgfjh1MwIqfxaOpC1WqNvAt+mOhOBAtZ6gBA9a5yiVOso
 PAdGbmlhGY312ijexZmFTF34VWGurqwx+Uo+gHBGkQcNoXxzajFDZNZyoc2OypGfB19N/pIf8
 sELNjG9edzVCJw371NH1KiVZEaVbNuVQwNVr6rw0JvJYj/DomPJO+5xJH3a6YVjzkuvTeFvxa
 AMl2K9WDt0f7NXG87vBrD1vLNip0XhMzn+WA01o66HPllZ8wEOziHbAumpSjZqMZZEtUf8aoL
 dq9KRhnpaHbAIKiypmun8QSb6OYg+S8QE7baladevfR0tZc9I5rEgqy6uVyRIKaERMoH3dUxg
 AmWg6KNsdaMdJ2AXW2SkIufFO+aD2NsvuBBcgctlL7kZN/iqtZEIYqfEqDaBXOxbh/sdybXAr
 I8byi/+wip1I/hZmcudCmgu9M1dvA3TTu6J5jyCW4pWLU/AoRYPJtv8tj9e3wIyZwPwuV+pAR
 SfviyuEGNX2B40Po9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Maybe dmc->df->lock is unnecessary to protect function
> exynos5_dmc_perf_events_check(dmc). If we have to protect,
> dmc->lock is more better and more effective.
> Also, it seems not needed to protect "if (ret) & dev_warn"
> branch.

I suggest to improve also this commit message.

* Please reduce uncertainty.

* An imperative wording is probably preferred, isn't it?

* Will it be more appropriate to refer to the action =E2=80=9CReduce the l=
ock scope=E2=80=9D?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the change desc=
ription?

Regards,
Markus
