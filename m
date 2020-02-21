Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665B6167E6F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 14:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgBUNYB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 08:24:01 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52265 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBUNYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 08:24:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200221132358euoutp02b35ba8f95ba422dbcd7ee0ffdf293a56~1ba4gH1ct0042700427euoutp02N
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 13:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200221132358euoutp02b35ba8f95ba422dbcd7ee0ffdf293a56~1ba4gH1ct0042700427euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582291438;
        bh=cuI5yqQy9lm3oM5kNN1Ooe7HUzA9bMYoiTHONcqUpI8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pL52/6GGDKq1EiWCgVQ22tDhadPhKOHsCnLrtrgEkwK+lReWHo4LYUQmCOEnAYjFU
         aXizCYbD2xGF8DMTfTAyDDK8ON2HUocK1ZxLzZi6UKIXaDE7QMi667MH5f1XHm1t1E
         ZnLgBl+mBaCP9HIk0J8CMO+HJtUZ8/XQN1R4IrHI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200221132358eucas1p20a85c3e80cb1b725c355142b3fcfafe0~1ba4QT_qP0512805128eucas1p2S;
        Fri, 21 Feb 2020 13:23:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4C.F1.60698.EE9DF4E5; Fri, 21
        Feb 2020 13:23:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200221132358eucas1p27c02884550108bf3712d697d8f14f425~1ba31wdN30532105321eucas1p2U;
        Fri, 21 Feb 2020 13:23:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200221132357eusmtrp1a484ec18f4669f8a3dda246bec1d19e7~1ba31HfDl0122101221eusmtrp1d;
        Fri, 21 Feb 2020 13:23:57 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-66-5e4fd9ee860a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.D8.08375.DE9DF4E5; Fri, 21
        Feb 2020 13:23:57 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200221132357eusmtip25b14ebb49d9fe1d507d885ec24e9edfd~1ba3ZahHZ0994509945eusmtip2H;
        Fri, 21 Feb 2020 13:23:57 +0000 (GMT)
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
Message-ID: <b52332cd-1dec-fdfe-51fc-8605d94abe7d@samsung.com>
Date:   Fri, 21 Feb 2020 14:23:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221123813.GB5546@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7rvbvrHGczYLWaxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0eJ24wo2i9a9R9gtTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKO4bFJSczLLUov07RK4Mla9W8ta8IWzYvuy4gbGZo4uRg4OCQETib5f7F2MXBxCAisYJdac
        b2eFcL4wSnxctQ4q85lRovPha6YuRk6wjvkbepggEssZJfp/boFqecsoMW3XJLAqYYEAiQXX
        bjGC2CICyhJXv+9lASliFtjCJNG/cR4bSIJNwFCi620XmM0rYCcx4+oRJpCjWARUJea/UAAJ
        iwrESsxeeZgFokRQ4uTMJ2A2p4CRxKQra5hBbGYBeYntb+dA2eISt57Mh7p0G7vE9eMVELaL
        RP/7CYwQtrDEq+Nb2CFsGYnTk3vAbpMQaGaUeHhuLTuE08MocblpBlSHtcSdc7/YQI5jFtCU
        WL9LHyLsKHFhyjkmSEDySdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQ
        fDYLyTezkHwzC2HvAkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIHp5/S/4193MO77
        k3SIUYCDUYmH1+GYf5wQa2JZcWXuIUYJDmYlEV41Hr84Id6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhgNea72yGv/mPb1hMHZFg9DxWtvtsoaJ7Q5ckot
        tfLMzruu6fVjwq8P37mKRFdJ39RP3SZ969WNji8rNA2+sc3kzJK/e9g3Kpy5etGhmKOvb0s4
        ZXpNvfPcUl0meHFR4c9F391LjCy/R4oteJj8mJXTXUZNdf7Sc65nqpRtHng35lbKCW4r8FBi
        Kc5INNRiLipOBAAZUz8jOwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7pvb/rHGZx7bWWxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0eJ24wo2i9a9R9gtTu8uceD02LSqk82jb8sqRo/Pm+QC
        mKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mla9
        W8ta8IWzYvuy4gbGZo4uRk4OCQETifkbepi6GLk4hASWMkp87f3FBJGQkTg5rYEVwhaW+HOt
        iw2i6DWjxPXGZUAOB4ewgJ/E2lkGIDUiAsoSV7/vZQGpYRbYxiRxqWkOI0TDNCaJ/e+nM4JU
        sQkYSnS9BZnEycErYCcx4+oRJpBBLAKqEvNfKICERQViJW7M7GCCKBGUODnzCQuIzSlgJDHp
        yhpmEJtZwExi3uaHULa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3
        PbfYUK84Mbe4NC9dLzk/dxMjMOK2Hfu5eQfjpY3BhxgFOBiVeHgdjvnHCbEmlhVX5h5ilOBg
        VhLhVePxixPiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGAyyCuJNzQ1NLewNDQ3Njc2s1AS
        5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwMj0wjimnKFrj60gW8GJfvM5H+9b9j/tMiuXD2Zs
        eLfgS19CR1jGpEmWWioXZilfKTDIWmb/+Mu/t4XiC3y3ngurPeSR+jRR4fvqK/x8as61qnLM
        vOfFmnd9DHxV+GwT85nb839ecGFffXlTW/qz8Nk1t7yfpni92ims++7zO2njYI0Zb67NsVdi
        Kc5INNRiLipOBAC2sJJozgIAAA==
X-CMS-MailID: 20200221132358eucas1p27c02884550108bf3712d697d8f14f425
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

+CC: Rob Herring, here is the whole thread:

https://lore.kernel.org/lkml/20200221123813.GB5546@sirena.org.uk/T/#t

On 21.02.2020 13:38, Mark Brown wrote:
> On Fri, Feb 21, 2020 at 11:44:03AM +0100, Marek Szyprowski wrote:
>> On 20.02.2020 17:56, Mark Brown wrote:
>>
>>> Why would we want to encode the particular way Linux happens to
>>> represent regulators on a MFD into the DT binding?  It's not clear that
>>> this is a generic thing (another OS might choose to have a separate
>>> object for each regulator with no parent for example) and the compatible
>>> isn't adding any information we didn't have already knowing about the
>>> parent device.
>>>
>> Well, that's how the bindings for max14577/max77836 are defined:
>>
>> Documentation/devicetree/bindings/mfd/max14577.txt
>>
>> I've only fixed regulator, charger and extcon drivers to match the cells
>> created by the current mfd driver.
> We could just remove the compatible strings from the binding
> documentation, they won't do any harm if we don't use them.

Frankly I have no strong opinion on this. I've just wanted to fix the 
broken autoloading of the drivers compiled as modules.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

