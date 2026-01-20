Return-Path: <linux-pm+bounces-41198-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAvQGt8RcGlyUwAAu9opvQ
	(envelope-from <linux-pm+bounces-41198-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:38:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4F4DF03
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 263A7A039EB
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D0410D08;
	Tue, 20 Jan 2026 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NgR75AlM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hbuApsOQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374634BA3A
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952112; cv=none; b=iNOVQOo6GXTVgBdRxGYhMoxDcEOiNyQ6CP926dPyOeoqNy1SpAF96u/9cZTXU1v2Z6pjOvXklcxfNTOntCapi8GRSO1qVZ+OXoy+TRjZR/oUFxydQ8o+d7M+nB6TDSPFo/XOJNbtZlHPqwz9Ihzo4l14tm2kQqOohtwYCPUxsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952112; c=relaxed/simple;
	bh=XU5elMv4uS+fHPEIL1tortkvaB1Ybp815zAA1v7bRao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ4gBY54pJwilkF0OA3xkiEVe2eznpueOPMjmjMtOA7sP7bEac4Z1CVfRBAtCtDcz9k2MRl6LbmoCdjGY9018v2lc3hfBWkupg9hJWtKLX+N9qjDws479sgLPanB27SSnmFmxiZ30paGumgS5LJ8ITXDidX7a9+wYNoJbT06hSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NgR75AlM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hbuApsOQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KHTW14824387
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ia+XF08rhniSi/K/yTQ0EhSJ
	ZH5l2O8Cp8+zkPmZzTU=; b=NgR75AlMtAFYBDqsN+8fqPEBuBZLqTCx45HsdGDs
	I8txGupXXTbu78Jat2XNEWbepMQrz5jo7huv2JU2VIuP0/0hUSV5oWEzeHSbCiJc
	/TrkLh/uv0usiRKKPGX9cVPSwD8QxispkHNVvdPuo7+fBrVPFeYExKm6dsHmSG9y
	LsgOkrvZLmgI3BvbMXCHcrEbntWke+vDZrlvZVkj5BbngGlm/ActkrB+blCUXIcB
	f1JWeTfejztSXn5KEQvKmfy5upV2RpyqtdJJL7Jjbf/NqIgj5luhFiVc0PdPBTHk
	jWLdgJjiTGEs1KY9JDMVGn021knt8DSlAzwgm/9cWe/DWQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bte5e17s2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:35:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5014e3becdfso211644151cf.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 15:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768952108; x=1769556908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ia+XF08rhniSi/K/yTQ0EhSJZH5l2O8Cp8+zkPmZzTU=;
        b=hbuApsOQ5KlYi/BkwBs//YMrV1gCbjW+W4PgPXuEyWNqjTmCYhjk94Tkr613AsKy56
         4osi97AG2OuJS4s4/P7iHTFpC5KsarRkXQYwY7vD4+RwSnDZv21bP94mZkkm98XplM5q
         mEXhw92lc7Q+ggQpTyVjs4PqIJ3WxzbWNcvFQd51KzOktjlP6NbdjbHR6jy9oG/Jdwir
         xwMQ7ChAatnOqJ87iIqtiFrBSx/VPFUNkNvMl/SYG1c+hx4yq4Uml2MmOSw2QL6zvn0K
         /M9Oj9nop4sCScqyb69uroQnhQgzwzrdb/PXCKBGZechS9Y9XPsxQxV/hdwmQox4OruQ
         +OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768952108; x=1769556908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia+XF08rhniSi/K/yTQ0EhSJZH5l2O8Cp8+zkPmZzTU=;
        b=ibwIaqooWUBElkA+yoVDsyyFszYE3juUOxREa2AyhJwYjFoOinqnBlIJahkPFDBmQx
         pVaMQ905AG2QJ90OJ9dZ+4K5j9/f4IItdxB5GWN31JKnYuHwoPdn23nZLdJ6UTEQHJS7
         WA8JwkrnqLFocDQxge5m5kyx+3ilzF0vv3k5+12hcDc8dmpNrM1MwnCZoJDDJoLbiqL3
         jSxTcSPbSRIS6QaaXh9bFkKrrzuBPZfHV/7fFWt+fNZ4WDmu2BomMCh2rav4Z0wYyXzT
         9H1p0vjf6hUtomL4fUX7EFWQ+e7vG19XBX5Gp8X6pg3F6HAOcEMdnv+M5TuwSgXqHWMF
         di9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW05egTrxEWYVVgAGfnNPFwcQiJebz4IodWObRorhY49Xr23wkbdOgAjUZGMyzARoTpFJGi7799HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZsolmE+5Kh46uAVIQQ3tic3kx0V/JdSMULuNqFb8PO4NOrGv
	tyeqWC+Apz8gzuO316XNGoFve3B9VfXY+hneGmoS1W21SMQFFysqq/KRzrhtmrF1mM/cwRsrSK+
	ZGGag+Bo1I8h/3I58/NsWHFekJCeyLlXIzJjkIDBvO1HCC1cMQq9dG6dCaJ/c4w==
X-Gm-Gg: AZuq6aIq3pZeHM/pbCjKgvdSkIcSc3V4fgTsldgU18r+nQcwNfj3q7gsOilUJYRg54l
	o/MJOANYMyiEAb5bGzE8OnXWZDeb/L+U5okeUz/ucxizcQKu0TLSrOuSJemlh8/TUDGmfpcwlLv
	xkLZPMSbqOcJosL/0JFw7vwm7JaN9d8c14er+ts2PiA16w2N27dxDgJoleOdAYeLUNsL1ewOfsz
	j0uMg92PP4O4h9Ba8+bMEASF6p4hLbCFUYZDFrJFlnFCtNkyABdJDi14Jkbi/nJMcrsbEIxrLvL
	5mHnsbiWfrRshY3JFumCAT6XvE/+YZqxv0dpuTcJ0dSlZjuumiAQxbl7MhwTwAh65apmWoTlCMA
	f3ZGVAPuR7JUamlQMI06LehKwwTY8fLkGOoa5rK00QHpoPEOoILrOE/k0hXfZD05c0LVrK/w3oK
	MpGsL+HRzvBMXTU3KEYjxu95g=
X-Received: by 2002:a05:620a:5611:b0:8ba:41b2:da01 with SMTP id af79cd13be357-8c6a6963926mr1692848385a.71.1768952108328;
        Tue, 20 Jan 2026 15:35:08 -0800 (PST)
X-Received: by 2002:a05:620a:5611:b0:8ba:41b2:da01 with SMTP id af79cd13be357-8c6a6963926mr1692845585a.71.1768952107838;
        Tue, 20 Jan 2026 15:35:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384fb873dsm42409831fa.44.2026.01.20.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 15:35:06 -0800 (PST)
Date: Wed, 21 Jan 2026 01:35:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Sebastian Reichel <sre@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: Recognize "LiP" as
 lithium-polymer
Message-ID: <povftv7ajr4czsqjreottqj4is44biub44zjlg32ezho4rxb2z@r4x22qkw7j4y>
References: <20260117210941.6219-1-val@packett.cool>
 <bih6lxs4u7q2kfe4kmid35cpmnqmvjltvzv4wrowah6x7v3tth@kptyk7bnmnhv>
 <74de8f03-dae1-4bf9-a2a1-973952fee2e1@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74de8f03-dae1-4bf9-a2a1-973952fee2e1@packett.cool>
X-Authority-Analysis: v=2.4 cv=BKa+bVQG c=1 sm=1 tr=0 ts=6970112c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MEE0ftJ_FLxYTFGDHAQA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: L1sBnjUMopm0ukrIocCykPYzspTEqcdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE5NiBTYWx0ZWRfX/zhnQJKL0KUJ
 xpD6Q4PKITpewmEnPvxkE82wrUKbQKej5ca7zjMK2b8MsLvBlZwQYSvIuxQ2rhfSSPxMAXdMaYT
 NCBO/G9s3eFwKTxqgAKR4lmV4lQTDS3JTddMjNSr0zwT2Q1RoFeNpUB4DHP0YfCLQSHZ3V5z7Bq
 75MO3AKrR5BcPo0vKhuR9Gp4WkSYJ04GVuH7sGxDi6++aOsKt+7tJH8j2R2WyjkmrNsKXk6YjbJ
 prO6U9VwI5o+0VWrg+cRG79Mtf/fBYiyDg3TubX51dKgDwDfm2AcmFMylEZ6MP5ITpZpFHq5lhT
 NJxsXlLwvf8BJDtWxM5+QSPrxHYnIlQWyHq9tZVKA3v2fabGluqwWfh0/xsdpKijHn9Dw/Zu1ug
 4/2/w0YFMz73dfp8a611AvPiG1bm3R1LKWFblL7CaYJbT5c8AuTteGLltBG6AAg7I4KbvH4jwpi
 2bY3CME31aF52vp6Ebw==
X-Proofpoint-GUID: L1sBnjUMopm0ukrIocCykPYzspTEqcdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200196
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	TAGGED_FROM(0.00)[bounces-41198-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 58F4F4DF03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 08:14:12PM -0300, Val Packett wrote:
> 
> On 1/19/26 3:38 AM, Dmitry Baryshkov wrote:
> > On Sat, Jan 17, 2026 at 06:09:24PM -0300, Val Packett wrote:
> > > On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
> > > for the battery chemistry type, but only all-uppercase "LIP" was being
> > > recognized. Add the CamelCase variant to the check to fix the "Unknown
> > > battery technology" warning.
> > > 
> > > Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
> > > Signed-off-by: Val Packett <val@packett.cool>
> > > ---
> > >   drivers/power/supply/qcom_battmgr.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> > > index c8028606bba0..80e701c66434 100644
> > > --- a/drivers/power/supply/qcom_battmgr.c
> > > +++ b/drivers/power/supply/qcom_battmgr.c
> > > @@ -1240,7 +1240,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
> > >   	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
> > >   	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
> > >   		return POWER_SUPPLY_TECHNOLOGY_LION;
> > > -	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
> > > +	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN) ||
> > > +	    (!strncmp(chemistry, "LiP", BATTMGR_CHEMISTRY_LEN)))
> > Why do you have extra brackets around the second strncmp?
> 
> Copy-pasted from the line above (the "OOI" one) :) Didn't see that the first
> one in this expression doesn't have them.
> 
> Feel free to edit this when applying

It depends on Sebastian, but I'd kindly suggest sending v2.

-- 
With best wishes
Dmitry

