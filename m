Return-Path: <linux-pm+bounces-43794-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ/HGl2uqmluVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43794-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:37:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DDC21EDEF
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 873C0300B1B4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74CC2EAB61;
	Fri,  6 Mar 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="IIPRPf/V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17637C104
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793433; cv=none; b=Ph6WrHKIm3g2nq+xGjU7O4HnETjZaYyOJUuoK7FKByZMDVgVZtgQF+8KFUbu/s59G3r0fYhCzqWrrD2TQ5JafopnH8GAlZiXV1tiNGWAngPTxt95fg7ZtblBssOCkMqsiicgjRumTCzyP9iC9SYIQfyqRTvyaDQHpdbjp1xnHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793433; c=relaxed/simple;
	bh=9mQW205gegUibeTid/1e5hyvVPikyOjbbJTshSUvqqE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ti0TEgtyH/XFcB+6qm9bAPDB3EcYHzfXd4KEKlEIoCOqs7IX6GnaG0il1vQV9flyuBjOX2EdE/xiFsN8g0owl9E3gQoT5zooX8usMitpwwNealp0WEiPVNdrNTKUtPHNryAQEOazygtduVGcNBTRzDKogVm4QQ0dW0nUYHuBDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=IIPRPf/V; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b936331786dso984128866b.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1772793429; x=1773398229; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mQW205gegUibeTid/1e5hyvVPikyOjbbJTshSUvqqE=;
        b=IIPRPf/VjAEUXK8IyQI6dB7AJahg7RWN0BIknY7cs1Al2aaH1qimHs6i7pawIGUrqX
         aBc1Nslf7Kg9oY+W2vanwvTGk3ltaRcuCiCopK8wVNr8zNYLxxk4meZJPXmk9utElSw8
         F41of/pPfqErHw2h00WlD4cOll990+Tze/4WHyv7MeabOpmirywwPV/uhtInqJkH0CFa
         AOqTCp4ibA+NSsget7w2J3A683K91Rnzv9I5FxK9jwggUTGeUo8/lyxTzPUluFcavX+g
         YuamSImqSprJnKZTqCh2xY094YPt5lgYF0eI498QHjdNiqLKSMboazlBT/PPI8hVjVbo
         44Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772793429; x=1773398229;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mQW205gegUibeTid/1e5hyvVPikyOjbbJTshSUvqqE=;
        b=XCr/r+wiUdzUqlmm4TC1HMUi7sWKO88a0rQdHVqVb1cSdDJyYAfGQuwFi0gdi6we3D
         smw/jWQBt4CFlrimTfq1Cx9r7+Xt/bMPMd4/eIkP6jtD9hCTVV3saLaykuIPwI8oCbzN
         Ds9CycFp/hmv3vJkZw3Itv7LK10V1V7BLsivg/qvhx8sS2AZPo51pyRJeh+6rBgQZuo4
         /a3DSZE/mkQRcVqPTG/ZMctkOjabtcO370m28clF+2hneb6l7b94y5skhWVJdbNnXMrj
         b4JjAKryEuVbKVwNvDeSo/t/wJHNrgOkFY3StJR4k0e49adczjvmPiun4cttj6EBhFAj
         jtWw==
X-Forwarded-Encrypted: i=1; AJvYcCWA93PuWi/AjoaTLFIW9IFGp594/iS9Og4ksiZ+42H7tzTJuGMecnuiwA4UU8G3SWYS8/SJaX+NCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VZHQiZYxaJDakXY4BSa8k93smOJSaXMPBtjGTKFmI/7AofAZ
	Blty6cNELbI6/DiSoxiuco6M9I070rDBERBf1ctIlxVM3+KOKMi3xIm9VFKtDiOEa+Y=
X-Gm-Gg: ATEYQzznfBX4NHrZQVY+ry9xWcmcXs/jArtrrmIkqDE/5+l3L/J87Wj+Z2lvJwEm0dl
	F7gfePUib8Jn+iNlstiOgT7fqzIMPABzSuEgXNLX2T1Z0tw8PjttlVP3syTuY4slm0bc3Aejo9A
	1yuu/Tb9OYC2nFgStgVOGIyIvej96T9T++ocMHV0XNjDYOmsCxAOEXuTQlj4Ws5iUkmG/ff+v+t
	aNcAbF8zdS64A65uTePqLRHw1lnY0k3tpJYXYFqeGAJv90B6Xm6o/YAwi+AbgjRvfJ9KM8fY8Wj
	GW4iMm1TYg1m/q6QUmOqP8j+4Q0wsJsJr31HHWE488NfUmI+tkkoIhQs5CmZEMyYBCNXvOeJw7m
	m9BMX+RV9a41/LOz/p+VzJv4STrhizyyIR0xacAdG+E+Y/w2rEJqdSuHsfgTMEK3+NYv16laUF7
	Lz5wUV67mpUoHrTYf44GYqEJMF4FW+PgMAzHq4iqhijOl3W2ZxOiQCWtnMwrrylXobUT6S
X-Received: by 2002:a17:907:9486:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b942dfb4369mr108342766b.28.1772793429277;
        Fri, 06 Mar 2026 02:37:09 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8ad0fsm46007966b.19.2026.03.06.02.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 02:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 11:37:08 +0100
Message-Id: <DGVMTLXR7VVA.3UCTHBGDDIKL7@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>, "Taniya Das"
 <taniya.das@oss.qualcomm.com>
Cc: "Georgi Djakov" <djakov@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
 <20260117-efficient-fractal-sloth-aaf7c2@quoll>
 <59d9f7ff-4111-4304-a76c-40f4000545f5@oss.qualcomm.com>
 <9f8619d4-43ac-4bc0-9598-c498d59a27b8@oss.qualcomm.com>
In-Reply-To: <9f8619d4-43ac-4bc0-9598-c498d59a27b8@oss.qualcomm.com>
X-Rspamd-Queue-Id: 20DDC21EDEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43794-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Taniya,

On Mon Jan 19, 2026 at 11:28 AM CET, Konrad Dybcio wrote:
> On 1/19/26 11:20 AM, Konrad Dybcio wrote:
>> On 1/17/26 12:46 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Jan 16, 2026 at 02:17:21PM +0100, Luca Weiss wrote:
>>>> Document an interconnect path for camcc that's required to enable
>>>> the CAMSS_TOP_GDSC power domain.
>>>
>>> I find it confusing. Enabling GDSC power domains is done via power
>>> domains, not via interconnects. Do not represent power domains as
>>> interconnects, it's something completely different.
>>=20
>> The name of the power domains is CAMSS_TOP_GDSC (seems you misread)
>>=20
>> For the power domain to successfully turn on, the MNoC needs to be
>> turned on (empirical evidence). The way to do it is to request a
>> nonzero vote on this interconnect path
>>=20
>> (presumably because the GDSC or its invisible providers require
>> something connected over that bus to carry out their enable sequences).

Do you have any details you can share for this discussion?

Regards
Luca

