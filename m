Return-Path: <linux-pm+bounces-39167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F8CA0B8F
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 19:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F8DE31782B8
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEE350288;
	Wed,  3 Dec 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ObVrXR/G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711134EEE4
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780240; cv=none; b=qVEmXg3Y65noUzSr/2mAaG0YNa43JS9zmnccOGroHk91ZJQ76YLtHAY515b2XqGLht0Fh+8FbpHwipWQWsEvNrAJNgt8bvLxnSOvbh2b7a7XL/0IeQo4IqGHhNQ9D939seu/LnqbFI30i4QILDbDa0nsyYQ2m6U62b7swjrh6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780240; c=relaxed/simple;
	bh=IAArZcm2wSkF6VtcJYsSwPQFosqWc4J2GeZQUSxMWAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6CmKMhUoKOrKH14IIKwyuvEA98YNtS+0TzBlIpq5Y3SEhDS6eGfaT0kmCEhB6wapsXYxG/NR0SVS7mdSNR0OA65EIhwFuKBa0VhLsatvej6/ZLm6mw4v0FKHUdPKmQ3i7J3GtvQBXImwNAKayXb7RtSiuzy4s9GpHbx0b50BBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ObVrXR/G; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so5588865a12.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764780236; x=1765385036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tre/rf8HRcrussbSV2D3pHxXOcQLeC/eEv+L6zskgMA=;
        b=ObVrXR/Gsi3r5Oj+eL8gT7L+fxd8SLyEneI43+9GIyjQgDxiQhZQJzoL1FlRP1ouzq
         PIPtbJDA3195dzo148gxFxzXYGnBbaoueuxOj5BodtmaHc+y6JafKXsWFglGN6g0WCKr
         kQMIE2M2yQv6pJTIp6eWo9I9Cr26EEHVUSCbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764780236; x=1765385036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tre/rf8HRcrussbSV2D3pHxXOcQLeC/eEv+L6zskgMA=;
        b=bFzYWh6IePJdiznlkKs20BiB2WU/+vI7AuN60CIKEOTyqwfMBqzlHyela21u5ZMtDB
         FIRdGmGVXpwD89526fw4v5nTI5wsxnlmuivt/TP6WBWlfWWEvqku+VqiKnENju1cU8bs
         Em8tzXKL0ChGehfOoOBKRHaddT2tJMXK5hHCrVcqicywTvaWXYHQm26qSU0ITjgm0qx/
         BQyeXVihDg8CfRHYHBUpIz38nzcuickv120aLRAlUCq7pvoAR9ETjop1h9HkQXNueF4C
         c02bli9DM4NWQh2fr2IaauY9iyJ1s1H0ME5zfNNHFJBlDBgEknvLdWGLihddNGlBaN1P
         GUfg==
X-Forwarded-Encrypted: i=1; AJvYcCUvfAKmWjIye4Vbk3CNLZhMHHrVi9gHdqYH4hJp2K3dn7Wv4yweHJgbQWg8miNuS8W5T8D+tDh3xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmB4Yg8TCvbN5b+mGIzvTSKV6S2fB544qWlAGh2k7OjLZwnGZj
	NtUt2QIS8BVVc3N+20nQM95kHvosbNoQ/wNTgsF52rTTcfrE7GFN8Vb81kGnJog6IMVYQSCOM7Z
	w8vLQMSo=
X-Gm-Gg: ASbGnctZGjBSANu04vYN3LXT4iWL9ydFpyDGBmTF5uhtjtUNnAuoDFPyFg6OOv2i7mc
	Y2PqhBfDLhod5jzbnzUIUzOuD39X3uR2WDd+O2iCAPNxLZyc7XcEDUBbDXNcSOWaHgjuJZUl729
	CHjBWW0Kk9Qb5x/rcXP8CAZL1UXY1kwbqqSYLmnzKAj8LadbnlYLfB3pTGT/1OcNf19+Cn3i1jO
	zhuBGSj1qrWLr1ylM6Ut/avXymK90VViBkSDcl6dL84zrnRZ+5fPIQuwPkd+h2o8BPf4beZwGax
	J00P0t3+hhHOnbHDKIflvGK0E/Adpwi1Nx1QrdbdnxDOi+eSCfWAW97q4wxv2plo0Mb0xfT4nlJ
	eMoRclq2+6GSZ50fAfZYr+mpqTMbVV34XblWN6hX0mM7LP7uRkDCtQHtVh1MlHXnqI5B2MPDcPb
	SeGy48iutOcOz3iUZNRmSpeqYEJWDr4QxHYdknSkSzyB5zyblriE5NzvtsNAI+
X-Google-Smtp-Source: AGHT+IFo+K47zfVws9bbJrml5reAuBNCtBft6dLUdeV+zRleoSlvCBOm4TjrSOHyJDQ2s8d7KzMrig==
X-Received: by 2002:a05:6402:2712:b0:640:c918:e3b with SMTP id 4fb4d7f45d1cf-6479c49bf60mr2436107a12.26.1764780236026;
        Wed, 03 Dec 2025 08:43:56 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510510easm19989508a12.25.2025.12.03.08.43.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:43:54 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79e7112398so68053566b.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 08:43:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXshnBRClA8JZ/vmYSNUiWsgEu90nHwGfowLyqoyiRHtQ24mKC70ycwxVb0KCJw6TCOUjjiVf5JUg==@vger.kernel.org
X-Received: by 2002:a17:907:9706:b0:b76:3478:7d52 with SMTP id
 a640c23a62f3a-b79dc51a4fcmr293870366b.38.1764780233541; Wed, 03 Dec 2025
 08:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152437.3751325-1-robh@kernel.org>
In-Reply-To: <20251203152437.3751325-1-robh@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Dec 2025 08:43:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLCSGkNMpcKd11EhrQJieXn7J-7px-d_sJ=o+2UT5g=g@mail.gmail.com>
X-Gm-Features: AWmQ_bnLY8KW8oEzYYPFpNFQCtPmlo2omVWH0TluZ2sLvA-oifz7NT-KjCUAHKU
Message-ID: <CAHk-=wjLCSGkNMpcKd11EhrQJieXn7J-7px-d_sJ=o+2UT5g=g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Remove invalid tab character
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Akhil P Oommen <akhilpo@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Gaurav Kohli <quic_gkohli@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 07:24, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Commit 1ee90870ce79 ("dt-bindings: thermal: tsens: Add QCS8300
> compatible") uses a tab character which is illegal in YAML (at the
> beginning of a line).

Applied.

But I want to object to the garbage that is 'yaml' and 'invisible
whitespace has semantics'.

Maybe we can have a "kernel yaml" that just turns tabs into spaces
with 'expand -t 8' and make the rule be that kernel yaml files don't
have to participate in the mindless garbage that is "yaml by the
specs".

Yes, I know it matters for 'make'. That was a mistake too. But at
least we could *fix* the braindamage that is yaml, and we already have
a defined tab width for the kernel anyway.

          Linus

