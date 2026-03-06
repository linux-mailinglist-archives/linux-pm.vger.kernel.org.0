Return-Path: <linux-pm+bounces-43725-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOgYGvckqmkPMAEAu9opvQ
	(envelope-from <linux-pm+bounces-43725-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 01:51:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E021A003
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 01:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89C70301DD6D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0852EC09B;
	Fri,  6 Mar 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY0qC/VE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975952DC334;
	Fri,  6 Mar 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758259; cv=none; b=ZNXyAS5Q2Q6ncOkWCztU90Ud2ilG2E5oMQdFsDMh9zjrXISsG/1AvpQJIGVmWiYMdTk1G1YJe2JKygRv/0sgpfbJBIJ3RBNfYxkL6/u11X4QYGqWytr4LPwCzzHxXA1dEcvWCajv7acqBLFer1TXMjuM3t0/8oKh3+DXGUlsmo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758259; c=relaxed/simple;
	bh=rqLpQNdsN3bFAosqutwLfQ4hCid22S/GwXAsl9MyJZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jea0qfDnToc9J76JmSTXlR5KEuHXvSxOlwiPAr87apujv4OBPcrXuIgk3ugDieYZMnPsRbPDVaI4E245LZecHL7RkR8rRaPNasBR/UI5H8WWwf8CcD4kXdEpo+J1zWBKgW3sGIQpkFTJfQOADq0HouO0/pOZLu7l+RgLn8rbCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uY0qC/VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12201C116C6;
	Fri,  6 Mar 2026 00:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772758259;
	bh=rqLpQNdsN3bFAosqutwLfQ4hCid22S/GwXAsl9MyJZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uY0qC/VEaN2Yqj1KTuKX/T0rVcCP9sTMbZJLJcUIIJszbR0nY3u6B1L3MwV12ChyX
	 WkL1GK89L321Qcg0iCrR6sm7KnFtj4Xg89RZdSHcawcPti/JfT54MAPjjXtU/IzgXN
	 8m4vR/khFxXs+3ooRBtTS3STo+s4VyaJE5/Rii25vLOOPgc3zwTsYJLGlYMyny8XmA
	 chvmRzjueyfwpsuwXekgT5+T1FX4LAaz4W+SdYFr1ENULxcUR9rOONHWWQGYeQKYVI
	 PsbtdKYo8ceI9e6hBaOTt9jTKWBSLCwP5EHxrEVl0Injyq1Ywcp6SiQoYIgo0tO2Ne
	 oI8x+badEIpcw==
Date: Thu, 5 Mar 2026 18:50:57 -0600
From: Rob Herring <robh@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Nam Tran <trannamatk@gmail.com>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 04/13] dt-bindings: power: supply: document Samsung
 S2M series PMIC charger device
Message-ID: <20260306005057.GA877725-robh@kernel.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
 <20260225-s2mu005-pmic-v3-4-b4afee947603@disroot.org>
 <20260225-secret-amusing-cuttlefish-d3bee5@quoll>
 <DGPTBRX09EU5.1D1ZSR7EUV7AT@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGPTBRX09EU5.1D1ZSR7EUV7AT@disroot.org>
X-Rspamd-Queue-Id: 221E021A003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43725-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:56:58PM +0530, Kaustabh Chakraborty wrote:
> On 2026-02-25 11:44 +01:00, Krzysztof Kozlowski wrote:
> > On Wed, Feb 25, 2026 at 12:45:06AM +0530, Kaustabh Chakraborty wrote:
> >> +
> >> +  This is a part of device tree bindings for S2M and S5M family of Power
> >> +  Management IC (PMIC).
> >> +
> >> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
> >> +  additional information and example.
> >> +
> >> +allOf:
> >> +  - $ref: power-supply.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - samsung,s2mu005-charger
> >
> > Review from v1 still applies. I think you ignored several reviews, so I
> > will mark entire patchset as changes requested.
> 
> Somehow I missed this one... anyways I address them here:
> 
>   Why do you need a dedicated child node for this? It's got one property,
>   other than the compatible, that you're using. It could easily just go
>   in the parent without a dedicated node etc.
> 
> The dt node also references a simple-battery node, that's why it's
> required.

That can go in the parent.

Rob

