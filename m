Return-Path: <linux-pm+bounces-42899-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FbYJT7Ol2kk8wIAu9opvQ
	(envelope-from <linux-pm+bounces-42899-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 04:00:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D9164541
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 04:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EDA6300EC99
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6108D2D97AA;
	Fri, 20 Feb 2026 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVuzS3A/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308052D8385
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771556410; cv=pass; b=WA5351WF40gu7gYJTU4j+hBYLw9VFSyOfEup3tt9+d1aFvu8goACwhh5S+mxsIweqBWDHo9UIx0kHPVnuCR2OTaHKz4nX4jp1vdftN8bNkAHz9PO1jh2pHdLZIy/ojoGP6Tuyr0L7xRgWKwOZyFBcLpqEmka0Bna5ph+lapN9Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771556410; c=relaxed/simple;
	bh=jL5V55t1rEBj27+VWKWTlqwdAuocpvOVvYTKQbJZVCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPfQ/Vt3WtLEJnUmyJeJmCVJeuAj6iDkTJG+oTd/HZ2wCAgj9QJaV9kwZUIHyTlg609+ThJRBAN85i/MmVsi2e3m0gSz2LO8Fm8DqaJjWSozxl7COZY9MsQSxaV5kfiOUzi3rUUUsLoZK4f3tfR/WlRd1P/C1n0wMJCN0SE5yPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVuzS3A/; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38707d4c8b9so22904611fa.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 19:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771556406; cv=none;
        d=google.com; s=arc-20240605;
        b=e6xvQRsT5cHIw/0JU/20S/15Z5/t522Tx0CPKy0+q9TP9scJzjsSrXyhSeqY7/rCJ1
         PCOmodimzxHrhGuX1f+5bbrFROKOE1+M336FE9MwcsD0Uoll6r9ArEmtuG5FBrZRY5L1
         5oBf4iJ+kkmyCXcVUVZsQL/BSxrzszaagzNWfGa7t/3rzr912wKf9YByLaVQTpqk6bng
         lXNro1P+efsj25q+ngJQVFS589LEFf0wL6ohLVA7MMRYZ2bqtd84dijypx1K5LfXbuoD
         TsmC7dq5iU/VIYAL1M0yZ8+iZwNaQcRbqLCYpEcUapl1VxMsdAXA7tp1XBkOQW9TsEIL
         xDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hKJq4SbZvV5Qnlwxk5U0/GVmtjJHH6p7BfIFLrvgzoY=;
        fh=5ufHiOFinYi8f8wf2lzb6hKvEGzXkY9yZ/CrmNLKIz0=;
        b=FQ+w3F8hm4oTtv3azpwP8Z09KTszlpDw11RrAvDfK0qFqfTkQWL27aWXHhFQPTRUl9
         59JqJG2RaqexwAKVBUOgvL+tRuxU/5cU0fwJfDkruALh8/nf7i1QIF9v/U7BSJ447JEz
         AHo9aZFrGfRqLfrj7TYclInJMf7zMFfvS0uLMoFQaUyJRotGqh4gyMU5+XKrYAu6xoEc
         fUXxeuOwwAW7eR/GQMTX9cyxZ8hMXicIKZCSsLLNY51XLr1lrAUekvQb0IsyAFaW0DlG
         fsuD4XgQX1Rx/IhfckwJqLsvqHH+eVqMyJoAl9jaa5G/wbAMs34uqBhGOoSF6tG84Lcv
         QAlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771556406; x=1772161206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKJq4SbZvV5Qnlwxk5U0/GVmtjJHH6p7BfIFLrvgzoY=;
        b=DVuzS3A/taTGcwIrGFQp4IvIGh54AP88eAYOeQQib5mI0EigAvW9D1roeyn0ChNFC6
         EbCzZNwRhDhIsoeJHZh22bNg5WC9a3JDhz54Dl0ad0Ki2QPoYSarbbU/9KRSB3uiJzPF
         ffnqWE7WdbIJvGJSud3eUga85j9fNXg0a4BJ127AuhJLM9YOK2OhuO/lwLubvufSyZI0
         csGqfPfzTWeGpPE8JahLe7XvgvlG42qw441GE/XoTCPNVnRzvuFCgAMO5nO51aMeXKDX
         8mXaOG2fjp3T0JVzY8oyVtkRW98EC+nFtQ/XU9/YXIzLT171POcGZOTjZf8wjQr9L2An
         Gb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771556406; x=1772161206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKJq4SbZvV5Qnlwxk5U0/GVmtjJHH6p7BfIFLrvgzoY=;
        b=PHsQoUPoLtkIRxh3wJbZ1vMgKs+ckEeBc36Gzczs2yFILbNXkXvEOjGR1+IehwkN+1
         I5VZDu1X2C0FO2OhMEDE3qXEscuqglIpCZoSClu4K9Fx/Kb3eEzfLeCRPQYZTF6hBLEe
         n4ROSNoi/dv9XazAl05XkvO4uEsWE/rIf2aFtvreDGwRQqIBi46+/EMGF6/a2tK323RX
         Cjw8BAE7qifWg6RkWb5Lxxm1j+ZNduIu8D3Ukh58jp4CuNC0Mr9a/mtOGw0cNEsmNTZm
         3Ef7LgyvdHSOVE8tyQlwJ7wYJWnpl14tqu/eKETS62tOrW5r6OR+hSfLOJceucfT8G19
         8DsA==
X-Forwarded-Encrypted: i=1; AJvYcCWMSaKmx7/+QuOhiokUAwggUNh5tfyEHU8RpSPBbUN74JlRQ4cJacgvJf6UWOPMhemy+jXnAQF6xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEx41oua+ZxSeqgw18liEK4dBVTEj53NAppPuvhzSmDnOQZmto
	I6P94u4tT9nxFd5+sKjdRV9aRmHtqzGsZ3R9VDtHXkgE6WgiiMx+La4DRt+ve5FG9ynFbIrJD9Z
	TgsyMkZZdNOrdnETkI+CcBFt5e+ykTXY=
X-Gm-Gg: AZuq6aLx7aqLCLn9TJZyeMnXR/YI9vqi3NU5t9mHZ2GsYRdGb5VA85Fx9LCpHD7s08R
	ocmB1NtH3Y//PEe/jaHt+71PMCe0vckDbTlsL1DqxL9T4tDdW1qCssWaq6vF+bvqGsWo7dnYBno
	FJnlSWx2kXn59SiQ0AzH/gqGUwxh5vmth6PxJZsIRFXAWh5ArgMgVdsxGRuaXy06S+Woa4wqkJi
	rVBfCd2wavB/4akHHzCk8ZBi5ghOtl36B9Bp45tVttPv93zNjhG4aypgYEKUBUxmSgt00/5eqeV
	6bnjnIHvf/NJfipBmwSWepwJJJsgL75fV+AVvZ3pn6wrn/0KAfwzwnGENnjQ386kOBTb
X-Received: by 2002:a2e:bc02:0:b0:387:14c6:53df with SMTP id
 38308e7fff4ca-3881b997fc2mr53665881fa.42.1771556406012; Thu, 19 Feb 2026
 19:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
 <20260218-sm8550-ddr-bw-scaling-v2-1-43a2b6d47e70@gmail.com> <20260219-cordial-robin-of-performance-5fb88c@quoll>
In-Reply-To: <20260219-cordial-robin-of-performance-5fb88c@quoll>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 19 Feb 2026 20:59:54 -0600
X-Gm-Features: AaiRm50qTrqt8BSzzi0gs_vnlSMTOnmf8SWXzlWyfspsagrgKunuBjfwtusY52U
Message-ID: <CALHNRZ8qEJc8OSsrvCQC76_LjxA7KunrOonvSfq8bsFdYnKE+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: Document sm8550
 OSM L3 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42899-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[webgeek1234@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 182D9164541
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 1:52=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Feb 18, 2026 at 12:16:18PM -0600, Aaron Kling wrote:
> > Document the OSM L3 found in the Qualcomm SM8550 platform.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Your changelog does not mention this patch, so I assume it is just a new
> one?

Yes, I forgot about this when making the changelog. I had used the
wrong compatible in v1 and setting the correct one required adding
this to bindings.

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Best regards,
> Krzysztof
>

