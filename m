Return-Path: <linux-pm+bounces-32716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D466FB2DE7F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7633BCFC0
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173422069E;
	Wed, 20 Aug 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eauG6E/6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C572617;
	Wed, 20 Aug 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698355; cv=none; b=VxFNjTFleWkw48gkmccY+n6BrOYiRJDmGJnMI5xEq1ChqZJsoAHmZKH7nHUCutnc19Ib3Fu86WJFyIuPM5WJBwsD+JSnZSQfBeztiQHhzHWb6o4hl//k3QS4g42GCgslKzTUzQwNdJ2awoHo+eisiK3d3Iwfo/ize1h3JySlZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698355; c=relaxed/simple;
	bh=/I/dHRjBGYuGASvg5B1AJm+rfBmAQq+HTzMrKwlXJbc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tba5b1SIrhdOWHMk69r2nDekOB69FOVsUxyyWqTKpqrTuB/4YvxO/bTSZhSPt0HdOw5L4BlS3jgIK14UDDe2fWAqeViQSPPAehubWOZnEkH5tjKONVs+i4wG5RvI5GoCpFBk4OP6pS8+pRBs6TLPvMzfG31bbWcpE+EZTlJr2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eauG6E/6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4717ba0d5dso692187a12.1;
        Wed, 20 Aug 2025 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698353; x=1756303153; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I/dHRjBGYuGASvg5B1AJm+rfBmAQq+HTzMrKwlXJbc=;
        b=eauG6E/6dCOJRenCce7h1bmCyx9YhCkrI52vXeUvKix2vFfIIpLgzsoXzABjJDCNWp
         tV0JuDQjsauFeJHvw5fmrCDzJkZIUyySNZvCX9OG3+4r+Srqh2RNTrP4FcS4CwKX+RY0
         RUluss5hopvPFqm+8Ig51K25uEoRTc+goMB+W+TnnmzXm+A8pJ6k5VA8gbGxRPBFKtXJ
         2rxQcCJwOkKrW87H9Np/AXX/xRYwfeA91MlIDgbQEoDpFGy+Z+TTj2YpWGGqm2mKmAAO
         DnkF5V/SHJFb5wF9HrfUOgm2MlPZiD+47uJk5Ubw9vv9Os4mEY5bGHcnfZjgbf7u5Wd0
         uSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698353; x=1756303153;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/I/dHRjBGYuGASvg5B1AJm+rfBmAQq+HTzMrKwlXJbc=;
        b=Kxgf/5jBKEE/oMd4oL+oBy2oaRIcTfm1gKRNm7k7QdZlJCba306s5sGABVewAns5Kj
         rdDcMCaE4jUzaYUuqLsLHHqennrgNmQkFKCqnWchSeDafFSG4BolmIWU+REFxyUPTVv2
         OznMeYYf+P4iJg2zCHvHobJ0uufMuMhj38RZZ1dVIm8NHAhUKgn+fGSyVmzrAx4ioWz0
         OVAQzH7yCdThgECpZNqdtiuGV2NZUebMnFfNHRmeFOi10NgSzA4zT/NQAwj0NqFu1AEr
         wdoAwlsSNTh7vwAsbc+MfmJU0kD+S+oRe1dSLnDtUlDgFNvsFluG4oL5LQW2YwKNb/iQ
         faNA==
X-Forwarded-Encrypted: i=1; AJvYcCWiL+9JKJ3Q48yZOSthh50yJa1bUDGsHPs6OEAtB10hI7dTdBX2it9cth+hJe2Lb7LsBg94c5tgccQ=@vger.kernel.org, AJvYcCXNrqqnO9VNo7URGJndndEE4FBRMKeeMb3gNLepLz47ZODXJNdrh4XW+7GJucLOfkJqgdvDCO84m7LBvZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4Zg0BihIQRM/7/280mGGcYKAFZxcJ4gFQxaDf4VJelkMR0Dd
	QK6EowMx7MJY5yqBXjVwLsLFP8v8oirfScAA4Q0d2Nl9nLTiycEcduQa
X-Gm-Gg: ASbGncvSyFf2wI7zwFNHVCL+mD5SYenZeUHfoSVrwp2/HVqMyQpGid9CIjg09FK5Qn3
	6iGeXTX0zLwm8Gy2X8+E008836THaftnS6jgFYJ09BckKFaRD6AOG9ttVGQTzxevqIReVBocJt+
	zJqkLrI5o2IFDjF7a+N/Roejo/ryzjq3NHYUSRJ8aZgIaEVCb7dKfYLLpCg8W0Ma1lWbNVg1Vp6
	YiMd/jFYB6hBChyupMR4rOM2z44YCpI1r90Fh+SeqpHWS9VnRk8noxdBE6b3M3GGdiy022oKhpY
	sTNThPMP6kZdT6k9hz3wMnQixt5kzzyxMjZ2q4UfaVug1pfiWyIIHc1SYp7SmLfQon11do9zEp0
	Iy+NPv9HsqNLYs9tOA9fJgSTkKbr8AYNhr+Q=
X-Google-Smtp-Source: AGHT+IFEUhCfZhSIdcuvT0PizgfLdYl1oK3oRrZJHPYBxmESKzd6y0QFP1umUTSxCR7GgPNH8CwZPw==
X-Received: by 2002:a17:903:1a6f:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-245e0a01363mr90709155ad.19.1755698352602;
        Wed, 20 Aug 2025 06:59:12 -0700 (PDT)
Received: from localhost ([2405:5700:316:3af0:705b:4cc5:3482:3b54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f7b77sm27973925ad.117.2025.08.20.06.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 06:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 21:59:05 +0800
Message-Id: <DC7B4DGBA8RK.14Y0UOAKOEOWD@gmail.com>
Subject: Re: [PATCH] regulator: consumer.rst: document bulk operations
Cc: "Liam Girdwood" <lgirdwood@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, "Pavel Machek"
 <pavel@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
To: "Mark Brown" <broonie@kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20250819-reg_consumer_doc-v1-1-b631fc0d35a3@gmail.com>
 <dc1107f3-098d-4952-8133-9bd6068d1100@sirena.org.uk>
In-Reply-To: <dc1107f3-098d-4952-8133-9bd6068d1100@sirena.org.uk>

On Tue Aug 19, 2025 at 11:52 PM CST, Mark Brown wrote:
> On Tue, Aug 19, 2025 at 12:25:43PM +0800, Javier Carrasco wrote:
>> The current consumer documentation does not include bulk operations,
>> providing an example of how to acquire multiple regulators by calling
>> regulator_get() multiple times. That solution is valid and slightly
>> simpler for a small amount of regulators, but it does not scale well.
>>=20
>> Document the bulk operations to get, enable and disable regulators.
>>=20
>> ---
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>
> You need to put the signoff before the ---, anything after the --- will
> get deleted when applying.

Sorry about that, I wrote a cover letter that I later removed, and b4
ended up adding the ---, which I missed before sending upstream.

Thank you for applying the patch, I am planning to update the
documentation of the regulator API when I have some time, and I will
make sure that the patches are properly formatted.

Best regards,
Javier Carrasco

