Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E800255D09
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgH1Oto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 10:49:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33441 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgH1Oti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 10:49:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200828144936euoutp01b40862b3ba0e8ec7f4c5846c23f2c69d~vdgmevpX41155411554euoutp01B
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 14:49:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200828144936euoutp01b40862b3ba0e8ec7f4c5846c23f2c69d~vdgmevpX41155411554euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598626176;
        bh=rnJHZDd3J2Cg79B07RVoEV7HxwE8uhmX3bSXaJNxqDs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pnpm4ey7TSKo/uhiM2rz4EYvwE7vHPTKFc2Q0m61F6qEDlZ9yAZfspJuUk7YoI0G6
         LO936QYAvhpEfm1VbmXNNnpKwDrE9z2RoEAilyE96uB6pk/tFhLxvQsKpedZOXAH1T
         d/qnIegvCOZDOyeg61HDf9pYy1ci8h+tgJRTxy+w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200828144935eucas1p21bc6d076e38045d6b6e8590b1b889724~vdgmDisXY0200302003eucas1p2D;
        Fri, 28 Aug 2020 14:49:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C6.3D.06318.F79194F5; Fri, 28
        Aug 2020 15:49:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200828144935eucas1p144aa5bfceb24dc26b5149a4bcd462a48~vdglnRCu41371413714eucas1p1-;
        Fri, 28 Aug 2020 14:49:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200828144935eusmtrp1a5ca3fb1aa00dd2762742fb47b3cb456~vdglmZUdP0687706877eusmtrp1K;
        Fri, 28 Aug 2020 14:49:35 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-5c-5f49197f0318
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.1B.06017.F79194F5; Fri, 28
        Aug 2020 15:49:35 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200828144934eusmtip164aea37a1e5a1a68977a9bb8f8567f7e~vdgkZI_v01183611836eusmtip18;
        Fri, 28 Aug 2020 14:49:34 +0000 (GMT)
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation
 for interconnect properties
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     Rob Herring <robh@kernel.org>, georgi.djakov@linaro.org
Cc:     cw00.choi@samsung.com, krzk@kernel.org, devicetree@vger.kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <35d9d396-b553-a815-1f3b-1af4dc37a2ca@samsung.com>
Date:   Fri, 28 Aug 2020 16:49:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <65af1a5c-8f8a-ef65-07f8-e0b3d04c336c@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3e3V2lyfVqelpRMgysyAf6xy3DzAomVERQZKW27KKSU9tV
        SwkfvXPTzB7qDF8YipGu+cgsh4o1xJzQfJWvHqOYZBLzgSktt2vkf5/vOd/D9xw4JEaPCSVk
        fGIKq0yUJ0gJZ7zl7aJxZ9aG8Gj/GWMQM1l2AzHPixuEzPDsdyFT3m0UMgNzMwRT1K4jmMLJ
        Apzp79eKGN3XISFjantMMNa8bsQU9+sFzLPucREzmlNLMLbXrSKm+L6FCKVkuro7hGxs6DUh
        m1QZBLLG6ixZflMdkll1m48Sp5z3nGcT4tNYpV/IWee4paKUZC19efynRZSN5l1ykRMJVBA8
        Kn6P5yJnkqZqEZjuTot4MYugcbAM44UVwberVdi/kcJPPauNGgT63D4BL34hmO0dENldblQc
        LL5QE3YmqADIe5OP7OxOBcPTkR+OQIy6jkGe5amjIaZCQFc54hjGqa1gelLjGF5PRUGzYVDA
        e1yhp8SM29mJ2gs2VafDg1Ge8NFcLuB5C1xrLl1dNYeEhbdZPB8ATbVFxLMbTBmaVnkT9N5X
        OxYC6hoC9atRES8KEEwaKhDvCoYx4++VNHIlYRs0tPnx5X2gtb0U2MtAucDItCu/gwsUthRh
        fFkMt2/SvNsbluqKBDxLQGW24QVIqllzmWbNNZo112j+51YgvA55sqmcIpblAhPZS76cXMGl
        Jsb6xiQpdGjl53r/GOZakX75XBeiSCRdJx4hwqNpoTyNS1d0ISAxqbs4rK83ihafl6dnsMqk
        aGVqAst1oY0kLvUUB1ZZImkqVp7CXmDZZFb5rysgnSTZaHfa5uQEetcO75Izn49HeNLjA1qX
        g5r+qY5bb465hl6RHJgJq52YV0aYvMjlw/hovv9FVfCw+nRnvTJ9z6hfpDbT4sNNyJLivfaF
        xQx1eLzzsH2w4ldL9m9SlFaaT2wJrT32xePkYP38wqF206MYfYb4XmlZ5pGHqgdBPjne+lKx
        FOfi5AHbMSUn/wvR+ny4bwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7r1kp7xBts+i1vcn9fKaLFxxnpW
        i+tfnrNazD9yjtXiytf3bBbT925is5h0fwKLxfnzG9gtNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2Cz+79nBbjFj8ks2BwGPTas62TzuXNvD5nG/+ziTx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8Xt6
        ScEGoYq7716yNzB+4+ti5OSQEDCRmPTgJHMXIxeHkMBSRokV7/YzdTFyACWkJOa3KEHUCEv8
        udbFBlHznlGi7/g7VpCEsECGxLJ9LxhBbDYBQ4neo31gtoiAtcTqG29YQBqYBVqYJb5OmsEE
        0T2NSeJY70IWkCpeATuJTQtvsIPYLAKqEpeXLmcDsUUF4iQe9/5nhqgRlDg58wlYPaeAvcT/
        7oNgNcwC6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi
        3PTcYiO94sTc4tK8dL3k/NxNjMC43nbs55YdjF3vgg8xCnAwKvHw3mDzjBdiTSwrrsw9xCjB
        wawkwut09nScEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDU05eSbyhqaG5haWhubG5sZmF
        kjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGOZdvnHhyVU3kzdId3pL/tbQ0U/euK2ZP+LXv
        Wmdn3NMcFf1d9/VusG76/PfKB8vb8x4Ifuh9JHK1VCHkjETDOrf1T8wZctNe5Kzu//965/9Z
        fvdbUp3THl+canvvAHOfyHbF/f0Cfl5n7EW3T/aWmLS7/fRRzaclYXW9LAcLn4VKPY17l6Xe
        q8RSnJFoqMVcVJwIAIbpuC0BAwAA
X-CMS-MailID: 20200828144935eucas1p144aa5bfceb24dc26b5149a4bcd462a48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
        <20200702163724.2218-2-s.nawrocki@samsung.com>
        <20200709210448.GA876103@bogus>
        <65af1a5c-8f8a-ef65-07f8-e0b3d04c336c@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30.07.2020 14:28, Sylwester Nawrocki wrote:
> On 09.07.2020 23:04, Rob Herring wrote:
>> On Thu, Jul 02, 2020 at 06:37:19PM +0200, Sylwester Nawrocki wrote:
>>> Add documentation for new optional properties in the exynos bus nodes:
>>> samsung,interconnect-parent, #interconnect-cells, bus-width.
>>> These properties allow to specify the SoC interconnect structure which
>>> then allows the interconnect consumer devices to request specific
>>> bandwidth requirements.
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>> @@ -51,6 +51,13 @@ Optional properties only for parent bus device:
>>>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>>>  			the performance count against total cycle count.
>>>  
>>> +Optional properties for interconnect functionality (QoS frequency constraints):
>>> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
>>> +  passive devices should point to same node as the exynos,parent-bus property.

>> Adding vendor specific properties for a common binding defeats the 
>> point.

Actually we could do without any new property if we used existing interconnect
consumers binding to specify linking between the provider nodes. I think those
exynos-bus nodes could well be considered both the interconnect providers 
and consumers. The example would then be something along the lines 
(yes, I know the bus node naming needs to be fixed):

	soc {
		bus_dmc: bus_dmc {
			compatible = "samsung,exynos-bus";
			/* ... */
			samsung,data-clock-ratio = <4>;
			#interconnect-cells = <0>;
		};

		bus_leftbus: bus_leftbus {
			compatible = "samsung,exynos-bus";
			/* ... */
			interconnects = <&bus_leftbus &bus_dmc>;
			#interconnect-cells = <0>;
		};

		bus_display: bus_display {
			compatible = "samsung,exynos-bus";
			/* ... */
			interconnects = <&bus_display &bus_leftbus>;
			#interconnect-cells = <0>;
		};


		&mixer {
			compatible = "samsung,exynos4212-mixer";
			interconnects = <&bus_display &bus_dmc>;
			/* ... */
		};
	};

What do you think, Georgi, Rob?

-- 
Regards
Sylwester
