Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40377E1DC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfD2MFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 08:05:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54849 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfD2MFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 08:05:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190429120500euoutp01a7aaa343e13d560d4da5ff2e9be1b84a~Z8G262fhc2834928349euoutp01v
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 12:05:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190429120500euoutp01a7aaa343e13d560d4da5ff2e9be1b84a~Z8G262fhc2834928349euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556539500;
        bh=eGHEdyu2IGU4/fzxUVhTY3K3XmlUBeVys301lxmNEUA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u8LR/qZKFbX9Kq1XnrDWwDcBVrBFwkXOPd+a2tJBkwAxCmDmAyZeRC6cEFDgOKIEv
         YyVt+P9eRXCcg6GuyTbiSktWIr61ocotDJopJJJwWWJ1V3qOw4ng8GNfw8fbgyhaFI
         J+yKtJbKg1SkkHDehJp94HOryySQ/K36gPUk9JhE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190429120459eucas1p12fb8e69c7bf48beeed80fdb4dc233367~Z8G2G3OMh1885618856eucas1p1s;
        Mon, 29 Apr 2019 12:04:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.C2.04298.B68E6CC5; Mon, 29
        Apr 2019 13:04:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190429120458eucas1p1a0a10e7b555c43f57c32f81d6070f158~Z8G1P_izv1868218682eucas1p1u;
        Mon, 29 Apr 2019 12:04:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190429120458eusmtrp1a2f35b0e59ba70654f4aa0c1811c56b9~Z8G1BuBR82838928389eusmtrp1C;
        Mon, 29 Apr 2019 12:04:58 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-21-5cc6e86bab8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.BA.04146.A68E6CC5; Mon, 29
        Apr 2019 13:04:58 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190429120457eusmtip2fa23297e0a26cb891a05e0c809bc8a3a~Z8G0P6gS-0631606316eusmtip2j;
        Mon, 29 Apr 2019 12:04:57 +0000 (GMT)
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <86715dda-c1b0-5354-17d2-419f8137cb91@partner.samsung.com>
Date:   Mon, 29 Apr 2019 14:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425195156.GA31128@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuzszO6O4MruanjIrNwpL0pYkLiRSEDEZUn8URAa15WCia7bj
        IzVqtVB7qJVUuhmrBiVbofnKrIxc2y0tddMwNLPUHvjqsWYthuU0Sv73u9/5Dt85h8sQqjFq
        IRMdl8Dr47SxarkrWWt1tq6O+Wzds8Y0wuA7BeUU7hr/RGFTUyuFb34bQDi/+aoMPz+jw3kD
        wwRua6ug8YuMERp31BfJsSOnCeGCtgYZvt3US+Oe9DI5/vOgjsaWkSwKP+oMwz2T7njiaT/a
        4MFN/LhAclcMdpK7Z+yluUrzKTmXc2JMzuVWmxFX1ZLGOSoXb2d2u4ZE8rHRSbw+KHSf68Hc
        CjL+jObI2/TrMgPqWHEauTDABkNTzSuZyCq2DEFVYfBp5DrN4whKmo2U9HAg6Ct/I5vtsNvr
        kVS4gaCtNG/GNYqgtf0lLbo82AgYyu2kRPZk/WAy89I/E8E+JMAx+H66nWHkbCDUmQ+LHgW7
        GTK+mOQik+xyyC0t+Jc2n90FfdYKSvIo4VnhICm2urABcLHYU5QJ1hu6B00yiZfA3dEiQowC
        tpAB4/3HtDT1JqiytlASe8CQrXpGXwQt+WdJiQUw5JQgiY/CQN7VGc96sNjslJhLsCuhvD5I
        kjdCt7VMLsrAusPrUaU0gjtcqL1MSLICsjNVktsfqs+2z5zQC27cukSfQ2rjnL2Mc5YxzlnG
        +D+3GJFm5M0nCrooXtDE8cmBglYnJMZFBR44pKtE07+wZcr2vQ79eLm/EbEMUrsplg492aOi
        tElCiq4RAUOoPRWcbVpSRGpTUnn9ob36xFheaEQ+DKn2VqTNexehYqO0CXwMz8fz+tmqjHFZ
        aECM5qvZvi7AaWr3v96c6OtTUaMdjfaNoVIXHMuezHBmJceGRh6mLX7hP5XOLSeHCkN2+H5M
        ph228z6EYf41ZbU1PMy587ixa15pZZ//h/bozeFemrURdreGAMuvrwVbty2eEoZ3TsS4oWWO
        W3+KLNmG36dwfp5Hf1oNfnzC+7ZMTQoHtZpVhF7Q/gUzNr/6gQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4Pd2sF8diDK638VpsnLGe1eL6l+es
        FvOPnGO1WP3xMaPF5FNzmSzOdOda9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnG7cQWbxf89O9gtDr9pZ7XYf8XL4vZvPotvJx4xOgh7fPs6icVjdsNFFo+ds+6ye2xa
        1cnm0dv8js2jb8sqRo/Np6s9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mvo28BS0G1Yca9xGVMD42W1LkZODgkBE4mLF3cxdjFycQgJ
        LGWUmLDwEiNEQkxi0r7t7BC2sMSfa11sEEWvGSV+fZ7LCpIQFoiWeNV3BcwWEVCU+N02jRWk
        iFlgL7PE+l1zoToamCROH3sIlOHgYBPQk9ixqhCkgVfATaLp/Xw2EJtFQFWib9EMJhBbVCBC
        4sz7FSwQNYISJ2c+YQFp5RTQlpi6QAQkzCxgJjFv80NmCFtc4taT+UwQtrzE9rdzmCcwCs1C
        0j0LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEZgAth37uXkH46WNwYcY
        BTgYlXh4FV4djRFiTSwrrsw9xCjBwawkwutxHCjEm5JYWZValB9fVJqTWnyI0RTot4nMUqLJ
        +cDklFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgdF5/qGZv9rs
        ZH/NVzO6Z2LM+MZzZsMOZr6PB7/aXHF5Kc6z03zTbAXtx4XeLVdeN+zofKzPy92jcmSm+NW3
        vQXtXTvSNNt8LQ9H/ghkTGuY+3+RDXO0zPT3Zby5EpZvVN/pVO6Q/Lx260ofLaGa2nc5fkdP
        7rIV3PzErCZ1kSyLonWY747ciUosxRmJhlrMRcWJAAlgemkWAwAA
X-CMS-MailID: 20190429120458eucas1p1a0a10e7b555c43f57c32f81d6070f158
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
        <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
        <20190425195156.GA31128@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 4/25/19 9:51 PM, Rob Herring wrote:
> On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
>> The device tree bindings for LPDDR3 SDRAM memories.
>>
>> For specifying the AC timing parameters of the memory device
>> the 'lpddr3' binding uses binding 'lpddr2-timings'.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/lpddr3/lpddr3-timings.txt  | 57 +++++++++++++
>>   .../devicetree/bindings/lpddr3/lpddr3.txt          | 93 ++++++++++++++++++++++
> 
> Please rename the lpddr2 directory to 'ddr' and add these to it.
OK, I will rename it in the nex patch set.
> 
> Maybe whatever properties are common should be put in a common doc.
There are maybe a few common properties, but I would not dare to merge
lpddr2 and lpddr3 before consulting it with TI engineers who made
LPDDR2 support.
Could we work on a common file after the patch set got merged?
> 
>>   2 files changed, 150 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>>   create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt
>>
>> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>> new file mode 100644
>> index 0000000..ebf3e00
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
>> @@ -0,0 +1,57 @@
>> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
>> +* The structures are based on LPDDR2 and extended where needed.
>> +
>> +Required properties:
>> +- compatible : Should be "jedec,lpddr3-timings"
>> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
>> +- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
>> +
>> +Optional properties:
>> +
>> +The following properties represent AC timing parameters from the memory
>> +data-sheet of the device for a given speed-bin. All these properties are
>> +of type <u32> and the default unit is ps (pico seconds).
>> +- tRFC
>> +- tRRD
>> +- tRPab
>> +- tRPpb
>> +- tRCD
>> +- tRC
>> +- tRAS
>> +- tWTR
>> +- tWR
>> +- tRTP
>> +- tW2W-C2C
>> +- tR2R-C2C
>> +- tFAW
>> +- tXSR
>> +- tXP
>> +- tCKE
>> +- tCKESR
>> +- tMRD
>> +
>> +Example:
>> +
>> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
> 
> Since the lpddr2 version was written, we've gotten stricter about
> allowing unit-address without reg property. Perhaps 'reg' should be the
> max-freq instead.
OK, so I will rename 'max-freq' to 'reg' and add a comment with:
'/* workaround: it shows max-freq */
Does it make sense?
> 
>> +	compatible	= "jedec,lpddr3-timings";
>> +	min-freq	= <100000000>;
>> +	max-freq	= <800000000>;
>> +	tRFC		= <65000>;
>> +	tRRD		= <6000>;
>> +	tRPab		= <12000>;
>> +	tRPpb		= <12000>;
>> +	tRCD		= <10000>;
>> +	tRC		= <33750>;
>> +	tRAS		= <23000>;
>> +	tWTR		= <3750>;
>> +	tWR		= <7500>;
>> +	tRTP		= <3750>;
>> +	tW2W-C2C	= <0>;
>> +	tR2R-C2C	= <0>;
>> +	tFAW		= <25000>;
>> +	tXSR		= <70000>;
>> +	tXP		= <3750>;
>> +	tCKE		= <3750>;
>> +	tCKESR		= <3750>;
>> +	tMRD		= <7000>;
>> +};
>> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
>> new file mode 100644
>> index 0000000..fc7875c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3.txt
>> @@ -0,0 +1,93 @@
>> +* LPDDR3 SDRAM memories compliant to JEDEC JESD209-2
> 
> That's an LPDDR2 spec.
Right, should be JESD209-3C.

Thank you for the review.

Regards,
Lukasz
> 
>> +
>> +Required properties:
>> +- compatible : Should be  - "jedec,lpddr3"
>> +- density  : <u32> representing density in Mb (Mega bits)
>> +- io-width : <u32> representing bus width. Possible values are 8, 16, 32, 64
>> +
>> +Optional properties:
>> +
>> +The following optional properties represent the minimum value of some AC
>> +timing parameters of the DDR device in terms of number of clock cycles.
>> +These values shall be obtained from the device data-sheet.
>> +- tRFC-min-tck
>> +- tRRD-min-tck
>> +- tRPab-min-tck
>> +- tRPpb-min-tck
>> +- tRCD-min-tck
>> +- tRC-min-tck
>> +- tRAS-min-tck
>> +- tWTR-min-tck
>> +- tWR-min-tck
>> +- tRTP-min-tck
>> +- tW2W-C2C-min-tck
>> +- tR2R-C2C-min-tck
>> +- tWL-min-tck
>> +- tDQSCK-min-tck
>> +- tRL-min-tck
>> +- tFAW-min-tck
>> +- tXSR-min-tck
>> +- tXP-min-tck
>> +- tCKE-min-tck
>> +- tCKESR-min-tck
>> +- tMRD-min-tck
>> +
>> +Child nodes:
>> +- The lpddr3 node may have one or more child nodes of type "lpddr3-timings".
>> +  "lpddr3-timings" provides AC timing parameters of the device for
>> +  a given speed-bin. Please see Documentation/devicetree/
>> +  bindings/lpddr3/lpddr3-timings.txt for more information on "lpddr3-timings"
>> +
>> +Example:
>> +
>> +samsung_K3QF2F20DB: lpddr3 {
>> +	compatible	= "Samsung,K3QF2F20DB","jedec,lpddr3";
>> +	density		= <16384>;
>> +	io-width	= <32>;
>> +
>> +	tRFC-min-tck		= <17>;
>> +	tRRD-min-tck		= <2>;
>> +	tRPab-min-tck		= <2>;
>> +	tRPpb-min-tck		= <2>;
>> +	tRCD-min-tck		= <3>;
>> +	tRC-min-tck		= <6>;
>> +	tRAS-min-tck		= <5>;
>> +	tWTR-min-tck		= <2>;
>> +	tWR-min-tck		= <7>;
>> +	tRTP-min-tck		= <2>;
>> +	tW2W-C2C-min-tck	= <0>;
>> +	tR2R-C2C-min-tck	= <0>;
>> +	tWL-min-tck		= <8>;
>> +	tDQSCK-min-tck		= <5>;
>> +	tRL-min-tck		= <14>;
>> +	tFAW-min-tck		= <5>;
>> +	tXSR-min-tck		= <12>;
>> +	tXP-min-tck		= <2>;
>> +	tCKE-min-tck		= <2>;
>> +	tCKESR-min-tck		= <2>;
>> +	tMRD-min-tck		= <5>;
>> +
>> +	timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
>> +		compatible	= "jedec,lpddr3-timings";
>> +		min-freq	= <100000000>;
>> +		max-freq	= <800000000>;
>> +		tRFC		= <65000>;
>> +		tRRD		= <6000>;
>> +		tRPab		= <12000>;
>> +		tRPpb		= <12000>;
>> +		tRCD		= <10000>;
>> +		tRC		= <33750>;
>> +		tRAS		= <23000>;
>> +		tWTR		= <3750>;
>> +		tWR		= <7500>;
>> +		tRTP		= <3750>;
>> +		tW2W-C2C	= <0>;
>> +		tR2R-C2C	= <0>;
>> +		tFAW		= <25000>;
>> +		tXSR		= <70000>;
>> +		tXP		= <3750>;
>> +		tCKE		= <3750>;
>> +		tCKESR		= <3750>;
>> +		tMRD		= <7000>;
>> +	};
>> +}
>> -- 
>> 2.7.4
>>
> 
> 
