Return-Path: <linux-pm+bounces-36574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E72BF6E99
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2269119A0D6A
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4DB339B35;
	Tue, 21 Oct 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hs1OoVm4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C8338931
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054906; cv=none; b=hkozmIC9OwYA2CBVQPhfJr6gKBNvPaDT+TTN99ToFmrIkOnLtonvqft5zxcQ2zeTgMP1Jpl60bHfMT8PQ2dwWG5kyeXXZdJEsT6GWEAeGFvNxAKoqkFM4E0fBNK5CIe9HGeWbSZ1q6E4g+8B7ssfaKG4/jZ6MAuONtok+jVMqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054906; c=relaxed/simple;
	bh=dtENIpP2ymfiJq2a+uxczvxyLyuLM+4hnAglKE1I+no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cl1C9wdElAlShmxN2PBk80f9pKztD1S0wsbQ4dI2LmtuWLoq+naRGxeNBC/6h1+915G++nWKTeajUmWEtdl0XwvvcYF95CMiTjrgdLryxsss0CTQj/PiisTZYJUiTOU8uKeY1/FV3MVmOkGzNSWPlruXdIMzzJ0YfaeXW2TJj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hs1OoVm4; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-784826b75a4so36664347b3.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054903; x=1761659703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MZkRqgQmvQUxe0HkH7YLcOV5VrwBVz6cPfsq0k36X3M=;
        b=hs1OoVm4puVOTtiW5YZKgNbhd7ncj7IncEdJ5JkCRy2ciVfXlDyCAV5ogD0ch8ChhT
         FWIDdh8ZwsHEOpyRj/8cUBJClnR9wCE+WJiLUUZHHQfPBABgkxLIxzltzkL6EBHq8yxb
         r/LVZ2JHgzvbiUwRd9M3tzPjV9LkiDmrSYVem1EQBQ+JRvb7fDDWUAvgEccuTA31hYGe
         JpO9bModiWT1/Ca/uuIU9EdCSOfCZAnMucQVYwbVaCdK620HVzoEoDePL6im2E8WD7VP
         3PJnI1jNWpQOmgEM0tWumPq8RHTuczLWxBPT0u5UmGSGsLDW4ZhixaygkS80rWwjswyR
         nOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054903; x=1761659703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZkRqgQmvQUxe0HkH7YLcOV5VrwBVz6cPfsq0k36X3M=;
        b=Pdb7mmHGpKHnuQTqNidXt8DB8nTtnW8Pjs6qwBG8JQgyH98Unf8SuwWFR+Lv89IF8Q
         JqhUKnG+thvO0Dbz9D+tIb+vE+h5UMUX9/s+82usHvxFCCHF3j7BJUd67GY5msHbpjw9
         V6tNbKAQbbC6Qga0X5+ugpJYOE4t3W777U81VcNchwcytPD4tFmHyL3cdRO+Y+0WM0th
         kDUJQtqestRSexLH2E0BrCtV40Q3oQMe2DWXI1s5gxwa1gM+uYjy0L9pRXHSl4wpwkrS
         S9QyrWt++09x86uvJxMEHgs+sJamPkvhz+d0Jdg7iEPqW/qsuTEfxN1+o4uKBtl6b7Xj
         zGDA==
X-Forwarded-Encrypted: i=1; AJvYcCWOnQmZ+YgKMWJfYsJE2tbY7StQfAVbSE1e66Ul1GwtVceIcCo7X+WSSaZXOhYv9vG4r8JNHJPZ7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHR+XrkeApHBwZ9pTO8G02RLF6+6/drsGrIzT9/mhUr+vywoeF
	VqpTFMJwlxF7eC++mPxhOcIK2UX0XjXYY4zjsz7f0l03tW436961+4G+hij/7ctiIFI2erJzBB1
	Lc2WW6TImW3SXv94gMqIB4tEFsdRXTRXYi0SEa+q9xw==
X-Gm-Gg: ASbGncusdUUp1gtxt4xSgqyUG9OfrQSxV6Y4YhSbHKqbKZQ8bAXqqXsArvaE+itFNLu
	kydn3k2RjN4olQfOUjFuNEH1S9dPo2s1OssqwIS0GikbVl0UkjV/MCmXh96cMi+XuTjsOw6pxPd
	HXhLwivt2REf6d5g6AjOzbqgRrzlw7DYEyZwnV2hUWbbRi9CQl1rIMk7/rdamQbN/0eRJroPoiO
	hviHfN6i4gQve2yFIlmHXWMkqHhRuUCPk8CxUETqFrr9PbWLHnCVSRGaMvvmxBwio8NgekU
X-Google-Smtp-Source: AGHT+IGwCSwvvGE3O6NbkG51mymMqSVErgL+88mCbcZ/Sh4giHy8+THUXBi9OuVSQ8LD5w3yhlK7YcdBM0SL+BQqwY4=
X-Received: by 2002:a05:690e:134e:b0:63e:3296:8886 with SMTP id
 956f58d0204a3-63e3297a274mr6263197d50.42.1761054902681; Tue, 21 Oct 2025
 06:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 15:54:26 +0200
X-Gm-Features: AS18NWBHdAFp1mwITr0UmXnrlHznqrsFfmK4pqdcEpQD90Zx_dU1-YGQ61Q86vs
Message-ID: <CAPDyKFofohpEDcowp-MwtJqKu4wN4qvXz+BKOG6=8jhWS_k-PA@mail.gmail.com>
Subject: Re: [PATCH 0/3] power: qcom,rpmpd: Add support for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, 
	yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 01:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>
> Add rpmpd support for Kaannapali Platform including RPMh power domains
> and new RPMh levels.
>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Jishnu Prakash (3):
>       dt-bindings: power: qcom,rpmpd: document the Kaanapali RPMh Power Domains
>       dt-bindings: power: qcom,rpmpd: add new RPMH levels
>       pmdomain: qcom: rpmhpd: Add RPMh power domain support for Kaanapali
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                     | 28 +++++++++++++++++++++-
>  include/dt-bindings/power/qcom,rpmhpd.h            |  3 +++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250922-knp-pd-f639194fd7c4
>
> Best regards,
> --
> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>

