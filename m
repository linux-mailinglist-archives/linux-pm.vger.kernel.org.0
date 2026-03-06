Return-Path: <linux-pm+bounces-43780-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFckC/unqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43780-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:10:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96D21E797
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459E630DD552
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8FC35C1BD;
	Fri,  6 Mar 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HL4FI8Jf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220735B62C
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791620; cv=none; b=YkBkvWUpU/z4goNu3BoVsPts/qtzjL5UDm4SsAEQU52CbvvoVGktAN/x2aw9/RdU9bEQUD/vcbupGjl1PZVTVFy68CzRxOstr7SHCs/lACd4oRgvlexdf9Jrs3dOTZhY4OxsA8xx2gsFC8B7qvCPLQchJ5yYW6dK4otyFca0NwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791620; c=relaxed/simple;
	bh=gEDlrhwnbLHEqntSSkEsQEo7gWXaJKYcg2RkMc37BfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6GBLZQmbcIRNlYAv9udjfcpzNBlUWAlEROpmMHByEB1IQKDOQw+UAQ7iraEt/W3q354JivOihIfbWu7IsYUc0vAoO2/bqY1BJdIV8FZZyi017j1w++7bTgw2kl582Ey6aNGmeDMlXxKJrWHLKnZQ568AZv9OVnRH/O6+D3OHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HL4FI8Jf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483bd7354efso118492445e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772791617; x=1773396417; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEDlrhwnbLHEqntSSkEsQEo7gWXaJKYcg2RkMc37BfE=;
        b=HL4FI8Jfk7jr5aKtIyJG4muLLEqLp8oio8ZHdAYDQORAEkQGfmWBK0sk/oj06dlDyD
         FFi3ZVi+cTQu8n+32z72pgC5FqI30npYQvefJ9eyKpIMaXQR0dgizZDtw2uWmvTcwStO
         +hm0QmsHHFFGvjpKGEDl0K8dmU7SlzMIkJoP0r0/DmQr7MrJ/Ysd8xwAjGxGvZJcKLiT
         oI9TXtphw+eLeFKb30H5p/jp0f9tevtLEizCwQZbGVV5YQBRTaP04WdPnWe3K3JbBbFO
         xbFmNfetjRIuJj2IPZIl7S0LosHru3i0gwnFYJAs8rMUV3ZZUFrRHCYVzVNatWc9FjUC
         RsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772791617; x=1773396417;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEDlrhwnbLHEqntSSkEsQEo7gWXaJKYcg2RkMc37BfE=;
        b=ONaU+rNulWoIvvqrzs39WR0WBAwn4SVKBGS10nnIdfN+tfbTXXVPi0z0cHbGHlT8h0
         h3Z3SwDv3oDuDRk6XOCXxsN8WSdGCy86jRAM15e5Wut4IDdgl3sWClW65e2KXnMbo0VR
         uKqwZRueZS4rMYA/OqxT15E++sUANUyyQ8DF07K50W3P5LnFJcQSftU/Bb/z/LjHAe8J
         Y1V8c3h/wdxwn1pHEevdZsNz0pg+EKYUdSiz0SDNhlNTRvmcyBIRFMbXql3pne4XrNMk
         Cnql4kCvCGyyNd/ghawdw+rVqJxNzt0ZYoyJLWSd4Lmjjbt42oOow1hqymTMR/Gg8FUv
         ZxPA==
X-Forwarded-Encrypted: i=1; AJvYcCWzu4aV/+96n7uJYziLzjqGeO/zKIIyGO15Spx7L+DietoIsd567ApjRO7aiifMSjxkY4ycvVGklw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfFQkqK6rh+ZKdkkNAtPPv5A2GY9q7AD7zP51i7hGQVfDljRc
	Vxl6CdZfaXgdUFDpg2c4+l6cNkOC+ygT3qMwhLUsFtUF6sBXNdIC1C/9FC7WUDcYFbk=
X-Gm-Gg: ATEYQzxqVlAWfIEHYVj8utMVZQHTORRQxZ9XpmtF+ki/EBp9vGFN6oHwLhjtOHGddtQ
	4ppXPYS+4iNjKyoi6rbf1mazMEwODCuMLZ+0iKmE8sYfQlihZRXEFGTKjugE4fBiG7wcB23FrXs
	gUp54mk7GjpAmFbkfFaCPhcnHx9sIolWmmsZIRufcvdrLuAyv/c8rj4Fq4hqu3SP7kHF7DeAEPF
	1cEIXxrLKbB+57Ht0v4fSPuZ03ZKoKzmGmpVyTSvRZ2Nx5NMt3KBQylOY0UTtkrZLlKH35Bj5Pg
	IR/2lwTG3XaFRbhwQTgkVvkEcn8T4/ng73Iqsgwv5z5xdso+/JzOZuV0r94lh8jJgyHlOUurocC
	HuA+HRsKWh3k8KIe0DlUAkQ9cFkTXSAGtNqpzoCVXZlStX5pHwQApZ80rqLf42xRSwEUhHTpsb6
	gNQooOKKL/Pz3Nkdrcyib32lJTHgyb
X-Received: by 2002:a05:600c:1986:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-4852695b649mr24350965e9.17.1772791617341;
        Fri, 06 Mar 2026 02:06:57 -0800 (PST)
Received: from draszik.lan ([212.129.78.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852378ea07sm15919135e9.0.2026.03.06.02.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:06:56 -0800 (PST)
Message-ID: <a03bd4a3c457cd3ade735b087fadedd1920c842b.camel@linaro.org>
Subject: Re: [PATCH v6 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Ulf Hansson	 <ulf.hansson@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, Will McVicker	 <willmcvicker@google.com>,
 kernel-team@android.com, 	linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-pm@vger.kernel.org, Marek Szyprowski
 <m.szyprowski@samsung.com>
Date: Fri, 06 Mar 2026 10:08:18 +0000
In-Reply-To: <20260306-hopeful-amusing-sawfly-e60c6d@quoll>
References: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
	 <20260305-gs101-pd-v6-4-8cb953c1a723@linaro.org>
	 <20260306-hopeful-amusing-sawfly-e60c6d@quoll>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9D96D21E797
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-43780-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, 2026-03-06 at 08:36 +0100, Krzysztof Kozlowski wrote:
> On Thu, Mar 05, 2026 at 06:11:53AM +0000, Andr=C3=A9 Draszik wrote:
> > The power domains are a property of / implemented in the PMU. As such,
> > they should be modelled as child nodes of the PMU.
> >=20
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>=20
> It is impossible to test a binding in a meaning of "tests", thus you
> should not add Marek's tags to bindings patches.

Apologies, I think it was due to b4 applying to the series and this one
slipped by me. Will remove.

>=20
> > +patternProperties:
> > +=C2=A0 "^power-domain@[0-9a-f]+$":
> > +=C2=A0=C2=A0=C2=A0 type: object
> > +=C2=A0=C2=A0=C2=A0 description: Child node describing one power domain=
 within the PMU
> > +
> > +=C2=A0=C2=A0=C2=A0 additionalProperties: true
> > +
> > +=C2=A0=C2=A0=C2=A0 properties:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: google,gs101-pd
> > +
> > =C2=A0required:
> > =C2=A0=C2=A0 - compatible
> > =C2=A0=C2=A0 - reg
> > +=C2=A0 - '#address-cells'
> > +=C2=A0 - '#size-cells'
>=20
> I don't see improvements about quotes.

Odd, I'm sure I fixed them at some point. Let me respin this.

Thanks,
Andre'

