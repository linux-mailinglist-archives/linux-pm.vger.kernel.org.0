Return-Path: <linux-pm+bounces-37725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AEFC467BF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49FA1885861
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC753081C5;
	Mon, 10 Nov 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEJiJ3Dn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jE05bRY9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA82FD678
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776480; cv=none; b=snYps7fGVjYtSh5/Q4TcYHhTrjxufolk43kbNESHsk/uXOjlpX0CnyFiTMvrUDRjilNuC2Oq6V+lzHq7NkPTnPapvhV1AsnufGon6iOd0oc4YBRU272sUmj2kQhDikBfCqqOdoDbaoImb2qrmr4WolFKHtOgvOdFWvn5sFDF5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776480; c=relaxed/simple;
	bh=dEmw6kanw7oApNACFWHvZqOchYoArn+wC2DUMU6QlAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txcskLDiT3/ywPMbch2CYonN8T2ZtIcesmTyzK8oGVYnzQOHoS4V0Pk6X2lr6GCPgQHaeBOnYFiPXW/OqN+nWfrbRB2zJrVRQ6oD8LsoI/KOmHD61SXJPZHgmAEShW/1rz1nSTgh1ZbH5YQlpo0upR5jzBaJGFJ6lG10/gSElQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEJiJ3Dn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jE05bRY9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9Cfn83146219
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eZWahx4P/zgVU6+skF6UkYVYNvWS/Hy3pKVmxvADPs4=; b=DEJiJ3DnyuWd5BmS
	IoEPsCOqfeaKiSk9awtH5VE+rCU9x+KtdQU9A93MQZACesfg84mic0CEHlW8spgv
	w+RKw/kx8TfwkuiI/iZoAZ412uSrcgsP/O9PQ005OyTvI+8YZ3wreE8fjtDQ8IKn
	pFTJNBt/cM9Qi9I8R433iHGJFLhsF06KhahfAhDS5o3IY3BL7lhnMlbvARnxCF3+
	f0gnUs0HuDvmqcWR0mHRJ79WlU3LljIcLaLaNwtzZae3dsO93ML3UHDHrGhsrqg2
	zoLe/OVQRLjxcCFD4oZIt8VRz51H6M96iPCm51uQYC9J4cHQERoOvXhT+8QAEGBR
	soP8cQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd7hrgwg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:07:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7aac981b333so2868449b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762776475; x=1763381275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZWahx4P/zgVU6+skF6UkYVYNvWS/Hy3pKVmxvADPs4=;
        b=jE05bRY9XSh3k5j3VdnAOxs02m9U4RHJb6mUS6s3vi5fyYxwSV25005SJF6so5ANW/
         KcVTXdRu0ndoBhL45YcIOsemDiGX3pU21oXD06XkoPsLFbTdiPIa2F0vfcJAy8T0tJip
         tVP2jx+9a0ft2uQexadg7bTBYaUiUx9f8ZEvK1Jif5+PJ9vaohFEUJgk0vaaMVks6U+n
         XRH6mAIwAE6W03JE35Y2YDYUsgLN0rR/COPjheN1um5cwWD5sX5GM+uRHihcr3bRecd/
         5pnWGlUWD3qsMImsZ5prH7443ZwVRxsWrz+oOalNmVEOukRU6vUlQfqaURUevnCO1Ibz
         zqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776475; x=1763381275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZWahx4P/zgVU6+skF6UkYVYNvWS/Hy3pKVmxvADPs4=;
        b=gmd+hDZwb9ivVcXVF5B2mwtDXi/iIJzIQSSQlGIe2b0PHBXGDw++isbGQ8US4pQXgg
         XHxuwRnB232KbCjQxQQSzmv5eHh+AkWuESEl4WuuLd1J/rAXfo7tp1/oAfya8QkMnClt
         ka0rHqlKAS776ebreUDYdlWqTV2wRrCFeNPR+JYJL6Jei7vpWjdZ4wogUb0eta7AKGcG
         urxx/uNOLHOqYkNd65sS+tEokbj7LHt0RLoKZRVzblSnYxVriPfKPeIwzJZXuWdWbDe3
         Zjj0AX/VQoO7xe84fo0QPzedBrODABI3hvRy0+X9Wrt2z2R+A6Ii+lI1g7hCmv0BEnfQ
         vFAg==
X-Forwarded-Encrypted: i=1; AJvYcCVsN7cegDQYB2u14a9ABBF/bNf/CzGANOn++ZykmCCvpNrL65vlVoi/7f2LaJqKKPwSFSjwOz3imA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvRHcFEcGoQw3dSqfeD1cdYOjTIv4uz3/1S/uwjqDm2b5AVFH
	+/utsiJw8hlvw4R8KPGxLER39Kt9+5JVRBH0xu0GfujfLDFWHz4B+wQHmgri9ur5UhUPRiv+Wtj
	jATrdvW8xYl/okpefJHgxSRrMhyiixCmP4M02IAN+DrdzUSTl8nyRiQn55LOjjA==
X-Gm-Gg: ASbGncuRUZdKGaZfCcDJtQ65Hu07WJGYAOue3Dm3d6Ew8wdYVyARf6OggZEh4+goFTV
	mSHlXwVlTJJ4FUsj84PaqOqfRvdFsJPjZoFC+XYYI3He10y58wU4Wuz8wSr2nrPX2PmNycA+Ei1
	I0VkV1funmiznhZUhMzdTQK6/3h6POUgfYnR49cUfBxvUGSkMDv56KRmws1wMXXsbVqwfBPNhdV
	/AR/RxzQ4A1a209cYxIZO5ZWUt9cAT5sW0EfGfeKq3XisF9r61cLtC5ALrO4ccGF8IhV6EV10jn
	pkQfkLQwH7lvzeJw2nah9qY+27RW4+pdE6qqy2bwULVOYt5eN2zJTeiYM2I84RhwGF2CQsVuifb
	lG0r5shMRCqe7Xu4zHuismPi+AGy8sB8=
X-Received: by 2002:a05:6a00:2356:b0:7a2:1b8a:ca22 with SMTP id d2e1a72fcca58-7b227085369mr9809204b3a.25.1762776474979;
        Mon, 10 Nov 2025 04:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn5vxnOQqfdElytemya9kAbp5X00+pQINjRD8DmLhndrB6Q6YObqiQqrvXSUIJAWsNUSA6Wg==
X-Received: by 2002:a05:6a00:2356:b0:7a2:1b8a:ca22 with SMTP id d2e1a72fcca58-7b227085369mr9809167b3a.25.1762776474442;
        Mon, 10 Nov 2025 04:07:54 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9635007sm11851294b3a.2.2025.11.10.04.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:07:54 -0800 (PST)
Message-ID: <b3e9403e-6194-448d-a361-45c645a2ab2b@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 17:37:50 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Queries on required-opps on calling dev_pm_opp_set_opp()
To: Viresh Kumar <viresh.kumar@linaro.org>, ulf.hansson@linaro.org
Cc: vireshk@kernel.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>
 <7paqqdkxfxd3hz76o7o4q7pkmc27czqtn3smffpkwoha7bncdq@w7ik7v3c5uwk>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <7paqqdkxfxd3hz76o7o4q7pkmc27czqtn3smffpkwoha7bncdq@w7ik7v3c5uwk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 14N2ASpVg5GvtUtbMgHtjEIKmcH33eJJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwNiBTYWx0ZWRfX9k8KuN2aHmQ5
 cvGltQPwJC0yjlT7H1vi3vqJTHOGHEjWAg9WAo8mWNKQOJI7O/tEVqtLHl5gbyGUvuUTdPa6Kd0
 Uj9yA/9GZg2aRa36IWwgzfL3vvGfG4YOuRaZAIeyB0cLEa92Tgl+Gk7bRnm7bLUX/XJpUUNQgK7
 zBaogGlrAItMH5NGxLEKT9ybdwho9bcRtI+paGHJywG7TkUUiQ0qxs6tQbmjIiHlRjEjudPHo04
 +qtsGui+skkTf2BLc5WZ7VXSU0iiQh6jW8fVyul0zDS9jigr9gjIil4aDCcJXPjkStDsp+jDPAy
 j7ISPjwuNG77dMAn2ciwgsB1ellquAVKquhYbU/Ps3c1WRvfYfVPivOcReGLve1p7UlMCL3wUfA
 W3BWCXf8dRURHRLrAgWGxKVATQO8Gw==
X-Proofpoint-ORIG-GUID: 14N2ASpVg5GvtUtbMgHtjEIKmcH33eJJ
X-Authority-Analysis: v=2.4 cv=Yt4ChoYX c=1 sm=1 tr=0 ts=6911d59c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DjpxQE5PB2NMj9FNeScA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100106


On 11/10/2025 4:54 PM, Viresh Kumar wrote:
> Hi Krishna,
>
> On 07-11-25, 15:25, Krishna Chaitanya Chundru wrote:
>> As you are aware that we had OPP enabled for PCIe[1].
>> We plan to introduce a OPP table for phy node also where we want to change
>> the frequency of the clock based on
>> PCIe data rate it operates. we planned to have the reference of OPP table of
>> phy in the controller node so that
>> when ever controller node sets a opp then corresponding phy opp also will
>> get set.
> A DT example could be useful here.
Something like this.
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi 
b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 33574ad706b9..833057f55328 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2050,21 +2050,21 @@ pcie0_opp_table: opp-table {
                                 /* GEN 1 x1 */
                                 opp-2500000 {
                                         opp-hz = /bits/ 64 <2500000>;
-                                       required-opps = 
<&rpmhpd_opp_low_svs>;
+                                       required-opps = 
<&rpmhpd_opp_low_svs>, <&pcie0_opp_rchng_clk_20_mhz>;
                                         opp-peak-kBps = <250000 1>;
                                 };

                                 /* GEN 2 x1 */
                                 opp-5000000 {
                                         opp-hz = /bits/ 64 <5000000>;
-                                       required-opps = 
<&rpmhpd_opp_low_svs>;
+                                       required-opps = 
<&rpmhpd_opp_low_svs>, <&pcie0_opp_rchng_clk_20_mhz>;
                                         opp-peak-kBps = <500000 1>;
                                 };

                                 /* GEN 3 x1 */
                                 opp-8000000 {
                                         opp-hz = /bits/ 64 <8000000>;
-                                       required-opps = <&rpmhpd_opp_nom>;
+                                       required-opps = 
<&rpmhpd_opp_nom>, <&pcie0_opp_rchng_clk_100_mhz>;
                                         opp-peak-kBps = <984500 1>;
                                 };
                         };
@@ -2106,7 +2106,30 @@ pcie0_phy: phy@1c06000 {
                         assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
                         assigned-clock-rates = <100000000>;

+                       operating-points-v2 = <&pcie0_phy_opp_table>;
+
                         status = "disabled";
+
+                       pcie0_phy_opp_table: opp-table {
+                               compatible = "operating-points-v2";
+
+                               pcie0_opp_rchng_clk_20_mhz: opp1 {
+                                       opp-hz = /bits/ 64 <0>,
+                                                /bits/ 64 <0>,
+                                                /bits/ 64 <0>,
+                                                /bits/ 64 <20000000>,
+                                                /bits/ 64 <0>;
+                               };
+
+                               pcie0_opp_rchng_clk_100_mhz: opp2 {
+                                       opp-hz = /bits/ 64 <0>,
+                                                /bits/ 64 <0>,
+                                                /bits/ 64 <0>,
+                                                /bits/ 64 <100000000>,
+                                                /bits/ 64 <0>;
+                               };
+                       };
+
                 };
>> But currently we see calling dev_pm_opp_set_opp() for required opps is
>> removed with this patch[2]
> Yeah, it wasn't working as we thought it should and moreover there were no
> non-genpd users.
>
>> Can you tell us if it is ok to call dev_pm_opp_set_opp() for required opps
>> if level is OPP_LEVEL_UNSET
>> or is there a way to know that opp is for PM domain (maybe dev->pm_domain)?
> Yeah, something like that can be done.
>
>> if know that we can call dev_pm_opp_set_opp() for remaining devs.
> We need to figure out voting aggregation in that case. For example, what will
> happen if we change the OPP from required-opp call chain and then a driver
> directly updates the OPP of the required device.
At least for our use case, wee don't want to set it in the phy driver, 
we want the controller
driver only to drive this.

- Krishna Chaitanya.
these.

