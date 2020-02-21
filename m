Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5CE167B06
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgBUKoH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 05:44:07 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51132 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBUKoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 05:44:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200221104404euoutp02196e228d19c1a8f289bb5a97143081ef~1ZPRVl5Xw2525825258euoutp02i
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 10:44:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200221104404euoutp02196e228d19c1a8f289bb5a97143081ef~1ZPRVl5Xw2525825258euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582281844;
        bh=8agBVibI27wvBvzg3vNVK2KuIXP3p0dC6rX3Pta/Ik4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bLPR7ypqZJdadc9M++y7sjMLV6vKQ73JN7ah2qiaMr+9BpEpiZU0WIdgSFioUP33X
         inu94vKjvte32HzTWxJzjE97mXbSR3QpzTP1ZnU1KkN35yeoTKnHz2dzFEpmAjIaqD
         sZ8+DzWljK0k11Cpj5BkXwSOSLX8l+xS7XQayB2Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200221104404eucas1p14283d5c0a0bb81c8c8146517a72917e4~1ZPRIc5kv2428624286eucas1p1E;
        Fri, 21 Feb 2020 10:44:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 52.3C.60698.474BF4E5; Fri, 21
        Feb 2020 10:44:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200221104404eucas1p147e55d6e5266c33892c8670425329cff~1ZPQx2Pq92430724307eucas1p1L;
        Fri, 21 Feb 2020 10:44:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200221104404eusmtrp1ce69e89c0424571f1bb30b480d534e33~1ZPQxIn_f2499724997eusmtrp1G;
        Fri, 21 Feb 2020 10:44:04 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-43-5e4fb4748b1e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C7.21.07950.374BF4E5; Fri, 21
        Feb 2020 10:44:03 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200221104403eusmtip16dc22efe67c669eb6bb34b08081c8593~1ZPQYkINd1718217182eusmtip1E;
        Fri, 21 Feb 2020 10:44:03 +0000 (GMT)
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible
 strings
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
Date:   Fri, 21 Feb 2020 11:44:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220165614.GD3926@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87olW/zjDL7vEbXYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaHG7cQWbxendJQ4cHptWdbJ59G1ZxejxeZNcAHMUl01K
        ak5mWWqRvl0CV8aGrm2sBcu5KqbsfszWwLiDo4uRk0NCwERizpHn7F2MXBxCAisYJfrvnWOB
        cL4wShxpWw3lfGaU+PjxM2MXIwdYy/+DQhDx5YwSc1oXskI4bxklPn9/xwgyV1ggQGLBtVtg
        toiAssTV73vBJjELTGCSuPHmFhNIgk3AUKLrbRcbiM0rYCdx9sludhCbRUBV4vOvs2A1ogKx
        ErNXHmaBqBGUODnzCZjNKWAk8fjEP1YQm1lAXmL72znMELa4xK0n85lAlkkIrGOXWHh3PxPE
        2S4Sv5oDIZ4Wlnh1fAs7hC0jcXpyDwtEfTOjxMNza9khnB5GictNMxghqqwl7pz7xQYyiFlA
        U2L9Ln2IsKPEhSnnoObzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQ
        fDYLyTezkHwzC2HvAkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIGJ5/S/4193MO77
        k3SIUYCDUYmHt6LBL06INbGsuDL3EKMEB7OSCK8aD1CINyWxsiq1KD++qDQntfgQozQHi5I4
        r/Gil7FCAumJJanZqakFqUUwWSYOTqkGxlMhDxOMKoRkJ+3vTakMnb5pWbIih0WBgpWer32l
        ofKu/gUVm4tnHRU7fjtGUo5v2owNb+44lr1cdUqO93Xp05T4jwcOh4eV7y195//ou/bflzcX
        6rL7tCWszpAT2TPX+v2TV17Wqe4ZKwwVdiz7+Vw884ZPBS9/8ALFsxrvtxvOMZnKz3GuRoml
        OCPRUIu5qDgRAFsezGo4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7rFW/zjDJ59s7HYOGM9q8XUh0/Y
        LK5/ec5qcf78BnaLy7vmsFl87j3CaHG7cQWbxendJQ4cHptWdbJ59G1ZxejxeZNcAHOUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaGrm2sBcu5
        KqbsfszWwLiDo4uRg0NCwETi/0GhLkYuDiGBpYwSX5+2sHcxcgLFZSROTmtghbCFJf5c62KD
        KHrNKHH21Vk2kGZhAT+JtbMMQGpEBJQlrn7fywJSwywwiUnizd2n7BANOxklfkz5wwJSxSZg
        KNH1FmQSJwevgJ3E2Se7wbaxCKhKfP51lgnEFhWIlbgxs4MJokZQ4uTMJ2C9nAJGEo9P/AO7
        iFnATGLe5ofMELa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfY
        SK84Mbe4NC9dLzk/dxMjMNK2Hfu5ZQdj17vgQ4wCHIxKPLwVDX5xQqyJZcWVuYcYJTiYlUR4
        1XiAQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTAJ5JfGGpobmFpaG5sbmxmYWSuK8HQIH
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoYHQ3nevxdVSMz03KD3wvht2ctL4dbMS+cIHz37ZninRJv
        vepKmJ2v/OwOf/j774FpLRkCet0CBsvmrct7fvj5juvngp4/qIr7LpMVk1dntcrI63qGi9Sb
        gJ6F+9402i+tdk/Pz+i+UvTN1POctvbhKW7vu53rA91v7I5PmTFheeGZyTZJr749UGIpzkg0
        1GIuKk4EAMhDqxTKAgAA
X-CMS-MailID: 20200221104404eucas1p147e55d6e5266c33892c8670425329cff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
        <20200220145127.21273-1-m.szyprowski@samsung.com>
        <20200220165614.GD3926@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

On 20.02.2020 17:56, Mark Brown wrote:
> On Thu, Feb 20, 2020 at 03:51:25PM +0100, Marek Szyprowski wrote:
>> Add device tree compatible strings and create proper modalias structures
>> to let this driver load automatically if compiled as module, because
>> max14577 MFD driver creates MFD cells with such compatible strings.
>> +static const struct of_device_id of_max14577_regulator_dt_match[] = {
>> +	{ .compatible = "maxim,max77836-regulator",
>> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
>> +	{ .compatible = "maxim,max14577-regulator",
>> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
> Why would we want to encode the particular way Linux happens to
> represent regulators on a MFD into the DT binding?  It's not clear that
> this is a generic thing (another OS might choose to have a separate
> object for each regulator with no parent for example) and the compatible
> isn't adding any information we didn't have already knowing about the
> parent device.

Well, that's how the bindings for max14577/max77836 are defined:

Documentation/devicetree/bindings/mfd/max14577.txt

I've only fixed regulator, charger and extcon drivers to match the cells 
created by the current mfd driver.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

