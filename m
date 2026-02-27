Return-Path: <linux-pm+bounces-43340-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEWqM+zCoWkVwQQAu9opvQ
	(envelope-from <linux-pm+bounces-43340-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:14:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675A1BAA55
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD6C3118729
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2AF44BCA7;
	Fri, 27 Feb 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn2ik2kQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3543D51A
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208475; cv=pass; b=LceqP6z+I5wjJEAh/xCVAgLMz3bMEpzXhJCJuHffMtttu6TGfsD0FqyDrFrqlzHcSTYtAzsraY5dJDWlF+Ybq9nojwaEcfDFl71Ywnl7rk+JXXf7ZZ5a8gXXBCyzovwXBrMZWHbFIAQ/3iBQ4i+HJUTgV/F4GI+yBUJ70FgNhcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208475; c=relaxed/simple;
	bh=nxgI9iSZO0Qu5sugKLMQ4YUqVNvHs2jgnwwQ8ze0Zkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWqagkOxOrlUlH16rrWh67WINzraQCEPT5x/WyidN7+FdoncBA7jhch2p/GGl96K/hj1t/mb7SoM1N5oXCNhoqofpxooHdiq/Ujz7omeBPuNPfdP3D+w/j/XIicZd3tbyQolgvSQTXOi3k5KHFugHXbFIX6Ml+SmcQPBhKs9Ogg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fn2ik2kQ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65bf302471dso2581428a12.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 08:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772208472; cv=none;
        d=google.com; s=arc-20240605;
        b=AFAxP+hjkcfgNu4Rig+PVpcyA3VwR2MSEb80F8Aa2lqUl0LHxzUgRnKB81WtV5FdSA
         fdNFBmMF/GVTMKbpJs+ZeecVBN0myEK23YKMgeYjGHvn2sYf+rfhgPh7rh62/1z6LAZV
         SBwEebyhBtSRGoorn9a3+pu9msuuIPPh4bpm0d8IlNJ/hmYWz6uEcC4QlJ4F+wbqQmZL
         e1tlmTbg+SEMuzJTXA9g1GxiKt/Uix/HZfnDeB6SjRlUeLS5IUbszLueRMyCaUDjS/k8
         6mzuTnNGPYr/cRy52ovPuMi3cZWMd97blyfRJZQ5NNwE0talxGVeAkC5ROlHShct1FVp
         VXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxgI9iSZO0Qu5sugKLMQ4YUqVNvHs2jgnwwQ8ze0Zkc=;
        fh=4wRJXhDZKr9EuF+GOv0T9PvRi5mxPJGefix+zjgZkr0=;
        b=gcvGbcASv7bwjhXiHrg0Q+k3+W42mGiwYVi4OKW9uG7a/ecp493LzD7Bc/dZ04vucy
         DzQTzeLPy8XUDHXA546gIxBm5IbHi4/ADxExIzZ6/E5WHfxWllbe2WSiLdeef5DgddEo
         /jVgoguWqI3EFvlt23EvM9YLV1vvs+5jCHFiYJM2wFkqyB1A61uF3bXeydhLX+6wEOfT
         M//k9RQhTBjs/CJiq7evqZ9vXs1KTZjz3d/m5ZXhk/ACXYU+2Ah5k1iam63G+r1Te+dt
         E+4G6YiXHpWlt7y9RwFopvQsew7C1hEfwlQaN6uJm5jlF4Jiv9LtteFSQtd/z+OMAmVc
         VQmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772208472; x=1772813272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxgI9iSZO0Qu5sugKLMQ4YUqVNvHs2jgnwwQ8ze0Zkc=;
        b=fn2ik2kQBdKqIzcz34U97r4pHEhax4AtV7wpb55vb450mN7En7LIPXXRM0JF6BcqkN
         advKlO1IX5KK6NrqGH0J1203nbFzW1WAkkSJDToj4uWDocdPYJt78QpwhjBvvDGRwr8H
         56fbQvKmy7ZK7au6rOl0TzMbygiHjdtgGi1PIkwoSEXSGUvM4OBO25LQnqOscLpu3K0f
         5kOq7k5KrnTdvp1ZatZkr+0ZojO27KlxyilA80n6U6cNJeA3bmJ+ANxI2czs6BVYgPE7
         d8xlJk6M72CTxnMvuRHEObrCy6mLcItOdn3d6nJ0Larc8lgmJzNoR1ssDztjdlMp3fjt
         xXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208472; x=1772813272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxgI9iSZO0Qu5sugKLMQ4YUqVNvHs2jgnwwQ8ze0Zkc=;
        b=n+UIHbx1ehI5UxEI4VzqT3q+O3jIgirHkw5lPj2dzTtLz4PsnJSxS02ij7BCECt6eO
         zBFgxH4BcOwicbZJTSBGciuBFDs5d5qMawukvOAlrszmQlBOcty39NXYAke1nkUK6Ilw
         Cnk/4nG8lB8owGtzQALPpoUZ1yVSVhanYRx6RctxDYGlQX4slvLzB1h0rQAKw0HGiXB2
         6JC/l3vY0vMm/OSTZpT2kJ8/iW9BVz3jTDxbSypvjMVMaCdLnG7g4gM+5qawayPeZ6e4
         TERU/u2L9IdAbieVqqg5CqIEJPN9zURWszwAQkmNtYt6KaUBpglhaj8Wa26ZWW8ZPO9J
         SLBA==
X-Forwarded-Encrypted: i=1; AJvYcCWGZ//pPihWA8NuBNoT/dfF+mxxat27xZhBoVFVRB8a9kEWsoo7c0NMbeMsZe3Uo0S7iOglvcg0OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNchs14sZdoYAEVzirpZUI0ZP9N5UF7/9Ivh7jgJh9jaJlhkW6
	NuHOyiLDclKURXr6kdbjtx48CS4FT/HgU2pViSrHz7CXvDmhZQcIfBS0qVW3YE31OL6WhuZ+scK
	6PlLyAsOeRqifteAH16UpWD2koiT/0gukrmKSE88Tyg==
X-Gm-Gg: ATEYQzzpS9Xm1zzvIC/H9AZB9Dj8lDcdIJGn/FC0ruULE3/gkIwM74m5d1E2WCTCe05
	k2B42Tc7LBKNYoGRiGMZWNo0uBIwKklibFM6wSxcbh/ER/6JCGLYGvq8pVKNyPFP2YA+CQzHOqc
	uz+zeRihtGOMQqRDdqYL8E3isYMOuxVHB8pypAlYs9FDP8wto5d0cAPeBUfM8gEcSspzlXIgF3j
	obg4KuqERnosWzbFxhfB+yp+cbTNs4dTnje96yfWe09jvvTQwCYw0b24USdSzgZw5glqkaeU1Oa
	8PUitwFfLPcbmmWuSfA2Ng==
X-Received: by 2002:a05:6402:2711:b0:65f:7206:851e with SMTP id
 4fb4d7f45d1cf-65fddefdc3fmr2005594a12.31.1772208471841; Fri, 27 Feb 2026
 08:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org> <20260227-max77759-fg-v2-8-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-8-e50be5f191f0@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 27 Feb 2026 16:07:39 +0000
X-Gm-Features: AaiRm50KBQWhZtwshhskDFWYXwe_qHblEDxQ5XPhC_Q5aPvqm1GnSmcN1ro1r9g
Message-ID: <CADrjBPoChg7qu7hJgh04WTuu5oxWsjor0syjD4U79CjUJoNbuw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] power: supply: max17042: support standard
 shunt-resistor-micro-ohms DT property
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43340-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 4675A1BAA55
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 07:15, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> shunt-resistor-micro-ohms is a standard property used to describe the
> value of a shunt resistor required when measuring currents. Standard
> properties should be used instead of vendor-specific ones of similar
> intention when possible.
>
> Try to read it from DT, and fall back to the vendor-specific property
> maxim,rsns-microohm if unsuccessful for compatibility with existing
> DTs.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

