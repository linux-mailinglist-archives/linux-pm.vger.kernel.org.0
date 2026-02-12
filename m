Return-Path: <linux-pm+bounces-42580-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCFONp8bjmlK/gAAu9opvQ
	(envelope-from <linux-pm+bounces-42580-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 19:27:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8AC130400
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5431B30405E3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DDD27B34C;
	Thu, 12 Feb 2026 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZo/kQZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9927B335
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920857; cv=none; b=LU56bN5mQnW8S7Wn+R9t+3BM0SCGcpvvFVZkLdpuM1WpmYWVve1Ib/qlXUtwqcCLWPE3s8SK9VJSiY+C2k3FFyNch3c+Wh4GFdcAPfacfI5dIhJatQxKfS9Ppwa2w26gXO9UyVMX2CC1C60cpcUZykW7mZRsijHrwpFxo0RlI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920857; c=relaxed/simple;
	bh=ufmEDOIfuDt3CbFMJGieDgc3OFPQ2BpzxMovoK9k9II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6Z278Jy5yTnlhbX9Okv+h/lr5HjC1p1i12CS3OcLaGBHvSR2wmitCe0PgRyHiIvbxSYFVk4cVe3UF2FIb0knLtnn4gFl1p0Vs4kZGLwF5qOEp+kKZKWK6fEXhqewGPkoRtuHD220gaBw5d3SBSHfheYwPPpioNASNFeVj/CxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZo/kQZT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a1b23c05so1732421cf.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 10:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770920854; x=1771525654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRTCx5otqsXIbaqSTlPHxkL1toAAMDZa7bOrLqMbOPc=;
        b=cZo/kQZTjS2vr5q1bFg8Vzkcsh4BkVL182YtD2u7NDBGXtyKIwaHmSJlDp90L0nIL6
         Zn87QmHrSsapG9WjxiPa9LtqJ4dPMNVlhCwxGbGXuLC+vPtu7RFCl+yzN021OXz7dB5X
         MMV8cITtg3Z8Vm5WVNakufIUctf75pGKbgr0kCAAitQZlk/sppz8zE/gcRfi4UYlyn1f
         N6qDfFizVLeiKtsXlzS9DuyiOYifLxHLXwyH5O95trf19M0b2HSDdIyewu+6VESi6+Bw
         8ktw982Z4Cw7X6GsIyYsrEofeTgiFI7XxswkQYh91xKt6N+TSiEbWrGoaEsiR8hxY0dx
         qs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770920854; x=1771525654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRTCx5otqsXIbaqSTlPHxkL1toAAMDZa7bOrLqMbOPc=;
        b=mbasOpf4b7eWry2I4LOuebwb4PsNBJrbaS3dUAzViYl4jpKUgitXj73a57K/QzLTCt
         qcsxGy4gTSMAc2tnBd2ZV0NpKtTUKF4JtXa3JRztaXLL2bjl16+OwHXlc2CeS+vcD5G5
         idggNo0l4azhOuUyGReCaMuf37DqsQ0tx/zn7cVxtybFuntmc/amvg6eqWnrvAEgyEea
         SiXfLVr8TTlf7oruA5vvHHq2qWHfRgpmZ8GDIHIK+Ra1hJNPGL/BuuVcN61gku8TmsWG
         XrgY2kvrLcSUFHH2q7oX2nLN2QxrgKM5t2Us8MJVx3t1zC5x8qbTEsb7bHydZAcOSlZJ
         tIeg==
X-Forwarded-Encrypted: i=1; AJvYcCUM5IFGaQ4XZUb2JMLmP0RzR8RudEF506HwjQ4339FbF0wu+K+Cuo5Tc1Cs3h/Dx65vxPHlkzcuzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8etdRP5N68RshUf7ByPTiFR6Lz4fly47TtAMcRiXBFPbBk15q
	CbIbMutGFbrhV0ZAw2dznno8i9zkMU0zwGn0aymCfV91mYmwbq1oDTwU
X-Gm-Gg: AZuq6aLm9F38Vlz8t8OedZ8wN6B5SdmCfPp0VwEbxNRhgOU8T1p7zMZqpNTH2BJu7vX
	PaoZlzkSlBca6I3HBtBHaz3ZBSqbbK5YX5kTAC3yV5OFt4CRBHeVr4B90BCS76WA2j3Wnejba2B
	BT1i/uXgBgY4ufDEe3tn+0J784/zixycsQPPBkxjNYTxM8SA11BxlSj2a4aXnviS+OSMd2jBucI
	BPkUTV8AzBDp2SKWe2PBeZqa3sDMobFw/VBFT9QpKW7PyTgMzHayGBPjbE0lxM4X8fJP0b+MnnK
	ifc5ifUMarac9Jv0G9BXeps7pp6QKk130qQtpYJiW/+oCFmk6RpcgO6J4l6Om5/dp1BqJUv5qcb
	oQdSQ/qDfT2INBIYviyai9CdMB+KXZixgdTWoIpHkbdw1q/4T8SMVQnFr6qSJ2qZ5rhRfrb/4iD
	MIqz2d2LThOYwxpHkTFkKMB5SNcf0Law==
X-Received: by 2002:ac8:5d44:0:b0:4ef:db28:1f3b with SMTP id d75a77b69052e-506919e9f83mr53865011cf.16.1770920853839;
        Thu, 12 Feb 2026 10:27:33 -0800 (PST)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc95acasm43835426d6.18.2026.02.12.10.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:27:33 -0800 (PST)
Date: Thu, 12 Feb 2026 13:27:59 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm660: add thermal monitor
Message-ID: <aY4br1BX9InqWUd6@rdacayan>
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-4-mailingradian@gmail.com>
 <e72ede03-94cb-45c3-95e7-63dff0ca3888@oss.qualcomm.com>
 <aYvNX718diaXDsBy@rdacayan>
 <f1fc24ad-054f-4731-b982-4c579abf46c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1fc24ad-054f-4731-b982-4c579abf46c1@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42580-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailingradian@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.13.72:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C8AC130400
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:15:04PM +0100, Konrad Dybcio wrote:
> On 2/11/26 1:29 AM, Richard Acayan wrote:
> > On Tue, Feb 10, 2026 at 10:59:20AM +0100, Konrad Dybcio wrote:
> >> On 2/10/26 3:18 AM, Richard Acayan wrote:
> > (snip)
> >>> +		pm660_adc_tm: adc-tm@3400 {
> >>> +			compatible = "qcom,spmi-adc-tm-hc";
> >>> +			reg = <0x3400>;
> >>> +			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> >>> +			#thermal-sensor-cells = <1>;
> >>> +			#address-cells = <1>;
> >>> +			#size-cells = <0>;
> >>> +			status = "disabled";
> >>
> >> Can we enable it by default?
> > 
> > No, the thermal monitor fails to probe if it doesn't have any channels:
> > 
> > 	[   17.728926] qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: error -EINVAL: get dt data failed
> > 	[   17.728945] qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: probe with driver qcom-spmi-adc-tm5 failed with error -22
> > 
> > Triggered by https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/thermal/qcom/qcom-spmi-adc-tm5.c?h=next-20260209#n945
> 
> You can define the following ones in the common dt:
> 
> REF_GND

Is there any (likely passive, if any) cooling device that should be
activated when this goes above or below a certain reading?

> 1.25VREF
> VREF_VADC
> VPH_PWR
> VCOIN
> DIE_TEMP

Maybe this temperature can be included, but I don't see any other
PMIC devicetree that has this channel ready-to-go.

> ANA_IN

