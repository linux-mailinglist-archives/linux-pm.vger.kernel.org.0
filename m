Return-Path: <linux-pm+bounces-26889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C0AAF8CF
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52A64E6170
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FF221FA0;
	Thu,  8 May 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLlOyVqt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6D220F26;
	Thu,  8 May 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704202; cv=none; b=eqxxm7aGx7eUMP1ufcn3s/WGTMGSI7l0Eg++TWA1863Lrq+Nzb3jDtNoJ3Lq4Zgd6yFhqGv631B8bfBJxPhThYes0A69CiDZcfyaAkfE+A+WZP/3o+P67EFlhmivU+SPRzVN35ECS+FCoSeCKVW8Hu16+299cVSn5LqRmpKYgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704202; c=relaxed/simple;
	bh=9EPr0UyMdXYUk+UXs4jteZKw6xDp0zVkVXceKKUv1Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmEPZE+UHnd9eyCtm0HWxbuqv2Lj1Khk3Xbg5Z7nJTpLyhiI5W6nPk3PisSrSHdny8XOreO1wOLbyWxqzayNJiyLbnd4NghXse04QeFJlg829xx9uG//2D7+rN72M4Tsp6qjSj3jrwjdPKAb6jtfw1L+5hNtv6q55z7NIXOKBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLlOyVqt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so3778594a12.0;
        Thu, 08 May 2025 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746704199; x=1747308999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ltr3kPU8Ou7XLMkgW3sKce+SE31ag1MbahmNgvMMJHs=;
        b=aLlOyVqt0WI2z9ABD2NfxrhAVGtt256C5EEoV4VcQ8h/8bx1yIl27G3yDUXi65XQh5
         HgUa3OObszUEQfw7OUhoIRgFAPyJlDxA/ouADJCxqI7R4YuRKnHGAgQ4sYv4JRN3Gxx3
         dqnbvzmYorc7CbW8LJGWFFpkaQBo1OsgJM/ynLnsDb3MXdw5uQAosy+UWd8JMsB2zR33
         I6K5EeJIII2Mo31lNNe2xiSMK3wy7XciACCljVKevOnTi0i91twRwZ5Cl0ASpZJfxJVY
         nhyApQQaAhBYeSh7EzKR4hZFPJSJMxdG9AE99asU/NRDEtiQsfnHA+nABBOUJfnoOqgH
         8lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704199; x=1747308999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltr3kPU8Ou7XLMkgW3sKce+SE31ag1MbahmNgvMMJHs=;
        b=vgkFAdREnLLd6xegt3SOuMrp8dVCnq9xONqdccn2woys52oa3FSiN9617YP7Jce/q2
         Y70VUUYXyYE32Z88meydIiHf+6SKoRvtmjyNVuWGemX//w+23GTjv8nyLoGol65ZjPY9
         3xQ4WQdvMbehabb6UuTUl/pypkgnyVhtyLPEnoppSOEErtI7cSbz170IC74zHEh75HxA
         dLx5Le7DQA0DjXu+fpgJfqHVd8IHFwLrxtu7o3hrY7Scrj+Jd0OlinZFVrPBnPnmKpMP
         0YCx7tGAGMSKGJWScwqfLwH9hlL457tm3xOxzyt/w6VZJ3tHBp72saHToRPsKiR8e4Sq
         FVSg==
X-Forwarded-Encrypted: i=1; AJvYcCUT0oGMONCAebTur9ax70lVG94zHuFCkyYdW13wm4o0sBSd3zcpkMMwZtGsukljd8ANcyNqn+iZzLA=@vger.kernel.org, AJvYcCV/3wMyJ1AdeYJFSocy0EOEWmwmXlqaIKTUAklIV5GeHfFHERfpAKYlI7ZmgI9fF6Kvmulh1sLBxpURQCu1+Yh/Xaw=@vger.kernel.org, AJvYcCXdtQkFejSZMxiHtrl/1t49bU70+pbq4sfcrYcNjkY0jrUfgH6eRNokkP5eL0kmbkRx2ERJQ5tMNdCPcNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqm60B+ht7B/Lk9sWA3UlbJsy99k70+tfWTcEciQ6t+KxNf0K
	kyJB7nhrD3E8CJ2GYAsSwBmXfA+GB3tPk4/Mo/hTjErc8AJZfV5KV6eWH/urAY9fJj/LKld94Ov
	ojxzUIR/+M1VuZxS+1iXf6wuc338=
X-Gm-Gg: ASbGncuAR+AbxiSrG4ukuxd5K+NJdM0XPWeP8GNj1bjDpYTI6fPWBmYQlF2t1kxz+0x
	IjxQSE7uUuQ0QXUETGLxVWWKGNSeZptltBliPfCpz1TEQW7OBIOU+v35/X7qqArteYe3DZ1h30i
	trq200iC5JYN7CDs+5nt4m
X-Google-Smtp-Source: AGHT+IFRb+7ScKez83qOuG4N6t6qIMEbVcI1rTEw0gYhc/qxLVO0dIAsrm1I+vwoVva6auYEZdGL5jWG49v19xFXQlM=
X-Received: by 2002:a17:907:9715:b0:ace:bee8:ae0f with SMTP id
 a640c23a62f3a-ad1fc8da3efmr281177366b.1.1746704198687; Thu, 08 May 2025
 04:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430123306.15072-1-linux.amoon@gmail.com> <CANAwSgSXNuNFQ6RiqiLEBY3eCmxz2hQYfWTFij=Vi8S7rS-_TA@mail.gmail.com>
 <97cfb30a-daa5-44de-ab29-f20b35d49d72@kernel.org>
In-Reply-To: <97cfb30a-daa5-44de-ab29-f20b35d49d72@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 8 May 2025 17:06:22 +0530
X-Gm-Features: ATxdqUE4hoONrfJ6klWGqObf3kEkWmvGg_F19UdLU4-d5Z7kZ2HdPSVuUXBp08c
Message-ID: <CANAwSgRLAydhpsF4kASBjeSw3QEVcCBGYk_tSgLAGHGSLQJcRQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Exynos Thermal code improvement
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,
On Thu, 8 May 2025 at 11:57, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/05/2025 08:14, Anand Moon wrote:
> > Hi All,
> >
> > On Wed, 30 Apr 2025 at 18:03, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> Hi All,
> >>
> >> This patch series is a rework of my previous patch series [1],
> >> where the code changes were not adequately justified.
> >>
> >> In this new series, I have improved the commit subject
> >> and commit message to better explain the changes.
> >>
> >> v6: Add new patch to use devm_clk_get_enabled
> >>     and Fix few typo in subject as suggested by Daniel.
> >> v5: Drop the guard mutex patch
> >> v4: Tried to address Lukasz review comments.
> >>
> >> Tested on Odroid U3 amd XU4 SoC boards.
> >> Build with clang with W=1 enable.
> >>
> >
> > Genital Ping!!!
>
>
> Huhu, nice. :)
> I make typos as well, but some typos are better to avoid. :)
>
> Anyway, !!! are exclamation marks and I think it is very difficult to
> scream at someone gently. I think this is contradictory to itself, so it
> does not feel gently at all.
>
I did not mean anything harsh with these !!! marks.

> Plus you sent it 7 days ago and you are known to send poor quality,
> untested code, so just relax and wait.
>
NAK - Do not merge these changes. The original code is in better condition,
and the proposed modifications introduce issues.

> Best regards,
> Krzysztof

Thanks
-Anand

