Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03899110E8
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEBBeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 21:34:14 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58008 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBBeM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 21:34:12 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190502013408epoutp045de35e8866057eb816136fa3712c59a8~aub5S__TK1575715757epoutp04r
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 01:34:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190502013408epoutp045de35e8866057eb816136fa3712c59a8~aub5S__TK1575715757epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556760848;
        bh=oahl26Hq31gTIlsrmWMFAvdvdfmVWescj8M5TaSbOPI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b7MbsB+y1Jd6Qxdxy8cUvztvsCBCfJDYKK8tBDgIQQCNi2jbSRjHcNBxITMatyYLM
         WIHwopF4Ttb3SbVHd8NHxX6Zj33o12+RBZvO2FTXenMFiMPXfcraRPuMBlHeI3987/
         3XYxrvT/LS5VUSN2ixjPcy2T6d4IOFwPxBVxLAWM=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190502013404epcas1p4742a0c7a3671da1d7b8224ec28c6de05~aub2DXSI_0375803758epcas1p4i;
        Thu,  2 May 2019 01:34:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.DD.04142.C094ACC5; Thu,  2 May 2019 10:34:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190502013404epcas1p18cb648d227cc7467d061171cde1bf803~aub1iueon0555305553epcas1p1L;
        Thu,  2 May 2019 01:34:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190502013404epsmtrp2152b782fbdfa1366ddfe1bae3b132768~aub1hqfiI0108001080epsmtrp2h;
        Thu,  2 May 2019 01:34:04 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-98-5cca490c99b3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.F4.03692.C094ACC5; Thu,  2 May 2019 10:34:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190502013403epsmtip2433bf94e54ccb100616cf38b6264b3a6~aub1LUDdu0637106371epsmtip2M;
        Thu,  2 May 2019 01:34:03 +0000 (GMT)
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ed07af9b-2d17-23c2-2f3a-dc832570480d@samsung.com>
Date:   Thu, 2 May 2019 10:35:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <32dfc887-5f67-3d61-08c9-0397d6852811@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmvi6P56kYg/V3dC02zljPajH/yDlW
        i9UfHzNaTD41l8niTHeuRf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktbjeuYLM4/Kad1WL/FS+L27/5LL6deMToIOTx7eskFo/ZDRdZPHbOusvusWlVJ5tHb/M7
        No+D7/YwefRtWcXosfl0tcfnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAzygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL
        9IoTc4tL89L1kvNzrQwNDIxMgQoTsjPW9jYwF+xXrXhwNKOBcZtcFyMnh4SAicS+E4tZuhi5
        OIQEdjBK9E66xgThfGKUuLdyJTOE8w3ImfecDaZl489dUC17GSUedMyDct4zSiw/9YgRpEpY
        IE1i1rNtYLNEBJYzSuybepcRxGEWWM0k8efrWlaQKjYBLYn9L26AzeUXUJS4+uMxWDevgJ3E
        mvXfwGpYBFQkni65CGaLCkRI3D+2gRWiRlDi5MwnLCA2p4C7xI7vW8DmMAuIS9x6Mp8JwpaX
        aN46G+wJCYFr7BL3TpxihXjCReL1ls9MELawxKvjW9ghbCmJz+/2Qj1aLbHy5BE2iOYORokt
        +y9ANRtL7F86GaiZA2iDpsT6XfoQy/gk3n3tYQUJSwjwSnS0CUFUK0tcfnAXapWkxOL2Tqjx
        HhJvF59mncCoOAvJO7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhghBzfmxjBSV3LbAfjonM+
        hxgFOBiVeHh/TD0ZI8SaWFZcmXuIUYKDWUmE99YeoBBvSmJlVWpRfnxRaU5q8SFGU2BoT2SW
        Ek3OB2acvJJ4Q1MjY2NjCxNDM1NDQyVx3vUOzjFCAumJJanZqakFqUUwfUwcnFINjMJLXwZs
        uM5lv0Js69qHv8TiEh4Umy9xP3ejZftM6Wttv1MP3I45J9fs/t/4SjO7fLmOsFtFjx1D5aSw
        yQ5rb9eqznn5/trG5cEHLBq5V3Ua/4tX2RN/ffWhtocOxmI/zSXTpyitbdwbKyQS1Hb91VaR
        N3pvDtV+ePDFRvVmw/OSoLfrHy2I/6nEUpyRaKjFXFScCAB+joN7AAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7bCSvC6P56kYg59NrBYbZ6xntZh/5Byr
        xeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4v4/JYu2R
        u+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPL49nUSi8fshossHjtn3WX32LSqk82jt/kd
        m8fBd3uYPPq2rGL02Hy62uPzJrkAzigum5TUnMyy1CJ9uwSujLW9DcwF+1UrHhzNaGDcJtfF
        yMkhIWAisfHnLpYuRi4OIYHdjBIPv/1ig0hISky7eJS5i5EDyBaWOHy4GKLmLaNE2951rCA1
        wgJpEpevPgNrFhFYzigx9+9SMIdZYDWTxKSPW9ggWi4ySexZtwhsLJuAlsT+FzfAbH4BRYmr
        Px4zgti8AnYSa9Z/AxvLIqAi8XTJRTBbVCBC4sz7FSwQNYISJ2c+AbM5BdwldnzfAjaHWUBd
        4s+8S8wQtrjErSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCY
        l1quV5yYW1yal66XnJ+7iREc3VqaOxgvL4k/xCjAwajEwxsw42SMEGtiWXFl7iFGCQ5mJRHe
        W3uAQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTAy/Phw
        po3/wom3Dx/efWWwQKgkQEP6beXURz/vFelOTjBaLyqyqXNZxpUzcdmnZ95eePnP/swpG/Wf
        vrutp/DuYuV8Bl9/l1U9TRmtV2QmlWY/7nGLPlv3dNFaFmFlpQSn45UMfPZ7ercE/ld0WlN0
        IXbpvrs1c5aaeF5tdnO9sM+eWTN8Ie8/JZbijERDLeai4kQAZsqJm+oCAAA=
X-CMS-MailID: 20190502013404epcas1p18cb648d227cc7467d061171cde1bf803
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
        <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
        <babae08b-3ea6-30f4-6a46-85dea0eacd86@samsung.com>
        <32dfc887-5f67-3d61-08c9-0397d6852811@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 5. 1. 오전 5:30, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 4/30/19 6:46 AM, Chanwoo Choi wrote:
>> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>>> Memory Controller device.
>>>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>>>   1 file changed, 73 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>> new file mode 100644
>>> index 0000000..133b3cc
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>> @@ -0,0 +1,73 @@
>>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>>> +
>>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>>> +memory chips are connected. The driver is to monitor the controller in runtime
>>> +and switch frequency and voltage. To monitor the usage of the controller in
>>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>> +is able to measure the current load of the memory.
>>> +When 'userspace' governor is used for the driver, an application is able to
>>> +switch the DMC and memory frequency.
>>> +
>>> +Required properties for DMC device for Exynos5422:
>>> +- compatible: Should be "samsung,exynos5422-bus".
>>
>> As I already mentioned on many times, it is not fixed.
>> You have to fix it as following:
>> - exynos5422-bus -> exynos5422-dmc
> I don't know how I missed it on my list. My apologies.
>>
>>> +- clock-names : the name of clock used by the bus, "bus".
>>
>> The below examples doesn't contain the 'bus' clock name.
> True. Thank you for pointing this out. I will it.
> 
> Regards,
> Lukasz
>>
>>> +- clocks : phandles for clock specified in "clock-names" property.
>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>> +- vdd-supply : phandle for voltage regulator which is connected.
>>> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
>>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>>> +- device-handle : phandle of the connected DRAM memory device. For more
>>> +	information please refer to Documentation
>>> +- devfreq-events : phandles of the PPMU events used by the controller.
>>> +
>>> +Example:
>>> +
>>> +	ppmu_dmc0_0: ppmu@10d00000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d00000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>>> +				event-name = "ppmu-event3-dmc0_0";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	dmc: memory-controller@10c20000 {
>>> +		compatible = "samsung,exynos5422-dmc";
>>> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>>> +			<0x10000000 0x1000>, <0x10030000 0x1000>;

As I discussed about the register region of clock subsystem
with Sylwester on patch[1], I expected that you used the regmap
interface to control the register region of clock subsystem.

But, this dt-binding documents doesn't include any information
about regmap interface.

[1] https://lkml.org/lkml/2019/3/6/878

>>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>>> +				<&clock CLK_FF_DOUT_SPLL2>,
>>> +				<&clock CLK_FOUT_BPLL>,
>>> +				<&clock CLK_MOUT_BPLL>,
>>> +				<&clock CLK_SCLK_BPLL>,
>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>>> +				<&clock CLK_CLKM_PHY0>,
>>> +				<&clock CLK_CLKM_PHY1>;
>>> +		clock-names =	"fout_spll",
>>> +				"mout_sclk_spll",
>>> +				"ff_dout_spll2",
>>> +				"fout_bpll",
>>> +				"mout_bpll",
>>> +				"sclk_bpll",
>>> +				"mout_mx_mspll_ccore",
>>> +				"mout_mx_mspll_ccore_phy",
>>> +				"mout_mclk_cdrex",
>>> +				"dout_clk2x_phy0",
>>> +				"clkm_phy0",
>>> +			        "clkm_phy1";
>>> +		status = "okay";
>>> +		operating-points-v2 = <&dmc_opp_table>;
>>> +		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
>>> +				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
>>> +		operating-points-v2 = <&dmc_opp_table>;
>>> +		device-handle = <&samsung_K3QF2F20DB>;
>>> +		vdd-supply = <&buck1_reg>;
>>> +	};
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
