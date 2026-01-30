Return-Path: <linux-pm+bounces-41756-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFrgLSBbfGkYMAIAu9opvQ
	(envelope-from <linux-pm+bounces-41756-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:17:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56385B7D3F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B726D3004D37
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3192D2491;
	Fri, 30 Jan 2026 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ow2eZeOs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fW+4/iHf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761EE284898
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757468; cv=none; b=l6ozI02UFb65VCtiP7ZmntYja3+lWCyl1oH0WN6NvCnx4Wl0ykknLdevFkDjYe4rxvMuGw7Uy1SA5rm0XFJfphbHQHa4z4hU9aCqQQyH8u6s1N3K4kMPBmGWTIlX/l3KwszEMdQyqTfgYBppfVXbsddqRIahPgBRKDMKUke2SJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757468; c=relaxed/simple;
	bh=kHg979/y4U/HsE5bnhdA8os5YKKrKNoOWwxMR9nynpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFjYb0ZFHtD2erwjAku6VRK9I6sur5BzcjRX0jV7oxy3H5GKPDK6UiDOUBzQZZh4KBxMlhzKgS3OgnMqSJ8RaMKsmUye3HJZKnCvyeZVxGU94XvmTh6UPwvSSjVzC5nH/hceDgn0+Bd1+4clYdQQzPxpDU9U/0HJCi7jMsX/qIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ow2eZeOs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fW+4/iHf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U7GR3J2413922
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BMGWf9KMb5syoT8JF8IUAJeZ1ITFz+zESEaYHIpsEGM=; b=Ow2eZeOsbwaRhy8c
	KrPDrKJa5PjkAirCjN0g8VH/4ZUDSdkgYrXK3RRbdLJzaC5kZ8lCiWwk4ZAp0MUz
	8o0GQmVLqtWirjouYU6/k9pcJmcmXRiD45pn7vcU3Tpp3Nk1KAjo35hoQdArRktE
	4WiAS2Yj3LxAKemkUj4+W29ltar19gggcJhBhVIz7FqjXlLuLraP1eP7gwEdxw0p
	99sN1jDQ6dF/g8RoxQRry9EwiqUTmwD7t+ac1OTK78dI88RKGm32WCLdQUgmSFq6
	KDJuOAH/BU6nAea4ARzJ/Hrpfa605oujalCvubC2kCHs92TXlJa+rfDVgOifF3ph
	q7WIfQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0r41g04b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:17:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f2381ea85so41745825ad.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 23:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769757465; x=1770362265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMGWf9KMb5syoT8JF8IUAJeZ1ITFz+zESEaYHIpsEGM=;
        b=fW+4/iHfBKmy+N2XHMDtC77HJOGQKGZvUmqiamJy3LuNDa/3oRpyRiiwRKghGx5/To
         V7aowu/GrvYLDlvC/PhAsxyWd7matLPH/I2wH+d914t/U+hXLnzWTIZFOWmiagT2BL/k
         49vIcTB5duK39PrIHshCXdzPd808+gV6AdcuU/z1cg0r+efSiyreWUm3vucMSKYBZ/FZ
         zUlso0lpn+kap61kU4Js9cA/8nhPsZTa0CMhoadFj366cdNrY/XVoZPHfuPFlmAnlUq+
         z/5zW8bMYiyerQVezwCeTmt2QfIxINKb/l8RnNxgsMFnJAA3kPlG3ykUM6FovMCbltIt
         4eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769757465; x=1770362265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMGWf9KMb5syoT8JF8IUAJeZ1ITFz+zESEaYHIpsEGM=;
        b=f07OrK0halbDbN8NOH2DB8OIxtlLX2vVcOyKK6kn4CKkN/vaewYUQr6iu/xPFH0+br
         rUlvWE2qehyvUCmHW3RV6HMajaFuTCJV+TbtRkRXFer4WGPnjy3ADOq4g5vksHNRxCdU
         ag9nTC6wfqT/bPlidsIsoL5S2VpOrgr+Fy1K+NUl0ij/M8Daj7P5hIVdUXX5uGGaiptO
         gqDStivSMzzxCnGkyrwEGizZ3ijMaLNL4aCNZ/PIQ7UK+0gzvFpor8ppRJUNuOUXVpBX
         3zLl8Bl6ZBUmPBpZ66XTAiW6OqQq/N5YE549XdVyzFZWnzpa6cPFgvaq9s4Q4wUkE8sz
         4VAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM+b6uiDM/LXJ2TbtsE3cvhjeZMQxzeRYRas+LFCifHzC0zBwrm8EOZaPwqVPY5HgRkHVprBD8PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRd8k5snJ+VaH4SmeM08T1e9CFMr86U0jGNXR7uu5FrnJVPutC
	eZuZRpT+GbFpLm4WtDzjF1NVSWjvJXQkfvuF3OUqbKd4dD6S/W7apg1r8+s/zQLC8ewUYDYXyES
	vrI5bJGktglfuwN7vMmPfdCnng7LofWq5Ba44ptvVBpH4n80rJ564qgRuwkrnPA==
X-Gm-Gg: AZuq6aJIc7cN67i/rjlTyMfHlTMpIjkwI7Vdfv7rOtKuYD6wYT2FcBLXu2+zhu7fqyV
	jyNBtgLXefLOvzQxwFIhykWraRn5THQ3jKS6EOnPipgoVlYA5WZhKkGuDLpyc0MNST6R81sRFvr
	wUghA1BvtF7zm2+0WBa7rKSQKrObF2IDcKyEswz2AU7qYgebzEwp3bzxmpCxIiEFPNBhkd0UhqY
	CKTdhabjeN8lSQMVjp1r5/yskoW/2nhtRkouTBA9kOU56cSaB0RxaF6TMAheckSpgQx/F7eBv5R
	AeHV1nQHwEvJ0s+24GA6B6IJXTGz2LY1+XZeM0IyMDU0aHLFKd+zhInEDNvJ22A2+AOxAkVmb7A
	98kFWnFC+/XdDy0dFuEBaCKESdg==
X-Received: by 2002:a17:902:f605:b0:2a8:ac0f:9aee with SMTP id d9443c01a7336-2a8d993d6e1mr18414345ad.51.1769757463679;
        Thu, 29 Jan 2026 23:17:43 -0800 (PST)
X-Received: by 2002:a17:902:f605:b0:2a8:ac0f:9aee with SMTP id d9443c01a7336-2a8d993d6e1mr18413685ad.51.1769757461653;
        Thu, 29 Jan 2026 23:17:41 -0800 (PST)
Received: from work ([120.60.134.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414f1esm67645165ad.24.2026.01.29.23.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:17:41 -0800 (PST)
Date: Fri, 30 Jan 2026 12:47:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] OPP: debugfs: Use performance level to distinguish
 between rates
Message-ID: <nbm2hpbh5ejpyig344tlfod7armbavv33u7mwo7ur3nhaarnvl@jkelr2ni4vpy>
References: <20260129173310.7241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <caqrguaqd4zvtxscnvptcdevftmml6w4g3xtaypwyzybziv4td@gdofbpdd7b4b>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caqrguaqd4zvtxscnvptcdevftmml6w4g3xtaypwyzybziv4td@gdofbpdd7b4b>
X-Proofpoint-GUID: 6tj0BgD8ISGHsrhT8_rlwW48fe3z6z6X
X-Authority-Analysis: v=2.4 cv=W541lBWk c=1 sm=1 tr=0 ts=697c5b1a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=2V1Ify4SBoSVV1xbfEOURw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jYuZTurSy6CcedfpMW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 6tj0BgD8ISGHsrhT8_rlwW48fe3z6z6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1NSBTYWx0ZWRfXw1CkrZXEehvB
 MG3TGdC+NbPaTdm2mHuTYLjGsD4bFB4//aKDgOylQ1DwBRvfqQybCklWGoHsPY/qinCYxg0hPfb
 Xe3wQyE/NJDtWvnUMn8azG29t1da8GK/epj4OFtqRwApRNMg5qOhs+ckh5SzUQEAk8FoADQDA2w
 YYLHdA9l/TyVyI8LzI9R4CN4GI95CJay+9UtgIBMrrOyCQdWz+sfLX04E6c0u3alDpoG9tOj4qW
 VhaGdvlQMFI0pr5m/gGYjq3uqi3BEZCXm793a36RsrR53yJ/Ft9qwcJB8Of3pHM8rZSdy30kj4r
 cJcok9I2g3lgQHhumJ9pkwhCnBK5dXGi3KRVx9i58HbUR9wy2XALQC+e2/rA4/z4Fh0HM+Yl6jP
 P/lMFV50dss3IrQfRTFEmuORW5yrGc0Alxkm8LdM5F5ZoAeVjziHBsVF9/EmThj4HLztMI+yFBH
 chW82u0iEPz09RV/PsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41756-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 56385B7D3F
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:01:37PM +0530, Viresh Kumar wrote:
> On 29-01-26, 23:03, Manivannan Sadhasivam wrote:
> > Some OPP tables have entries with same rate and different performance
> > level. For these entries, using only the rate as the debugfs directory name
> > causes below error:
> > 
> > debugfs: 'opp:5000000' already exists in 'soc@0-1c00000.pci'
> > 
> > Fix it by appending the performance level to the dir name.
> > 
> > Reported-by: Bjorn Andersson <andersson@kernel.org>
> > Closes: https://lore.kernel.org/linux-arm-msm/75lzykd37zdvrks5i2bb4zb2yzjtm25kv3hegmikndkbr772mz@w2ykff3ny45u/
> > Fixes: 05db35963eef ("OPP: Add support to find OPP for a set of keys")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/opp/debugfs.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> > index 8fc6238b1728..7c912bae2a5a 100644
> > --- a/drivers/opp/debugfs.c
> > +++ b/drivers/opp/debugfs.c
> > @@ -131,21 +131,24 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
> >  	struct dentry *pdentry = opp_table->dentry;
> >  	struct dentry *d;
> >  	unsigned long id;
> > -	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
> > +	char name[36];	/* "opp:"(4) + u64(20) + "-" (1) + u32(10) + NULL(1) */
> >  
> >  	/*
> >  	 * Get directory name for OPP.
> >  	 *
> > -	 * - Normally rate is unique to each OPP, use it to get unique opp-name.
> > +	 * - Normally rate is unique to each OPP, use it to get unique opp-name,
> > +	 *   together with performance level.
> >  	 * - For some devices rate isn't available or there are multiple, use
> >  	 *   index instead for them.
> >  	 */
> > -	if (likely(opp_table->clk_count == 1 && opp->rates[0]))
> > +	if (likely(opp_table->clk_count == 1 && opp->rates[0])) {
> >  		id = opp->rates[0];
> > -	else
> > +		snprintf(name, sizeof(name), "opp:%lu-%u", id, opp->level);
> 
> This would be confusing for devices that don't have the level
> property. Maybe add the second part only if level is used.
> 

Yeah. I got to know that the level field as an 'OPP_LEVEL_UNSET' default value.
So I can use that:

+       if (likely(opp_table->clk_count == 1 && opp->rates[0])) {
+               if (opp->level == OPP_LEVEL_UNSET)
+                       snprintf(name, sizeof(name), "opp:%lu", opp->rates[0]);
+               else
+                       snprintf(name, sizeof(name), "opp:%lu-%u", opp->rates[0], opp->level);
+       } else {
+               snprintf(name, sizeof(name), "opp:%u", _get_opp_count(opp_table));
+       }

- Mani

-- 
மணிவண்ணன் சதாசிவம்

