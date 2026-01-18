Return-Path: <linux-pm+bounces-41059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D07D4D39995
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 20:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D9353001623
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A4422652D;
	Sun, 18 Jan 2026 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1kGETeY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DA39FCE
	for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768765558; cv=pass; b=F3y9rey5Oj+EyGzP9PNIx69OVjvcYEQWN5Q3OrtTrDdyv0Br5JnbYOcuykRAY+LceJT8YBLTsk+ONdIx5YE/FNLdAr+++J+R0/E1G5br+0a68bcTvd57Ytk/jRNBWcp04Sr6zqBaNgX5tEFQrwQM0WZwkEWlHKY4gkqgFgQnGlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768765558; c=relaxed/simple;
	bh=KVHaohjIpkS8RF4XW8vpNt+aWDOb9cyMHNvbV9tdgrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+ryLaiiXvfwws/az2c1goA7WQOzyeJrdc4MLe61ejMcD6ZBnXOtzJs4dYrkWHCiZaMn/uiZFO3cMnjCyobDpujYeUGZAjH+OpysK/8TQ1JEZ3akn6GTwmOkFi62pYAcrtugqEn3lMWTkzXeS4USGN8lbu5Y9yyIFUCdgZpu3as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1kGETeY; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b1769fda0eso381960eec.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 11:45:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768765557; cv=none;
        d=google.com; s=arc-20240605;
        b=OZ+qMGA63rHc1v2HrrRvcHfGWfpCN6trtU2LjkAC3x5+wWenw7vOhuJ9YH3EwSVDfR
         ZmZ/rYzaA94c01SHEfE+LAMNLCuzYveiZDC8t8WQw9+G22Vlp/XcUgFb6KDrXV79Xidp
         O/mmsAgNLGkeSOYQzat6ufDS6XNTarFwZC/EZ/NrfhP++9am3EUGVP0+w4OhnXSlYEki
         7WVLzBqPEPp56fDkr4/fkk+XXKvFPOCswnmGFEBFWe/PVMCVwuEi5sIufCZ3cBLhCGvV
         7T4/Zeve0gM0W7nGB1utOmulhvZo1kOermsnDnt8TusXICsEMVSuOhRa47dEiEj5Il6U
         DenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngLJEmbzzfwIyJl3HgdWne+DdSWDFYCnHseYetxWc3E=;
        fh=ayvaKhII8eaW5vUpamEPmHcMMRrktN+SKBnWa8U8BMg=;
        b=PQeMTGtatMsoL0gizZDjzn4wq33p2YNGHj8qGShXYbjxGMsRdH6HcPrfZyDZgTlKoo
         iFLEMeYEt6AA6bQX0/8JsCurGVmCNdKdhO3d3Jv21otFe3rFXbo4a3QN93cgeQ+JpBjA
         tIOvdnJlJxxh6jOCG7bE80zbM2wE5XLkUCAua+x+Rut1819dfjHOWYq72BcwVJAq8jB4
         qwRE9qN1tp5vS224sB1Vh3G906iuS50rpXr3oqCJeVBf72Uh/zocmnZdqZoSoHzsTJ4E
         1v/8uGiT9OdrIhK2TPG7KYUdqrZJaLv7t1fQG5WLzizQ3/e1gAuRy7ecPi+jIom813za
         IrNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768765557; x=1769370357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngLJEmbzzfwIyJl3HgdWne+DdSWDFYCnHseYetxWc3E=;
        b=a1kGETeYn96vfAtUMnq3WWCUyDjZfuOjIYO5KJfsxBT6XOBL2QZUW8WlSERfWCZ+4R
         e0ThKDKGRjJJDvZLq025pLtHvGAHBPFmGRlh7DLTdTbQ/q8qqCIl1Gja4gWBeKDzzBei
         04rmBcVo3YV5C7B4iUgHbopUVNusdCjvLjJDb8khHlngeQtBAtDmMUm4FgUMu28bMWI6
         SY2xT1DgfE+DjPc2xE72ZtSsMjciuJlnNaa4WYlOhU0KmbyL7DKEeW1m87TPhiT7s2DD
         3vLQMsnPtUnwrWHMlfJxSom9JF2UQtYpwmz1VfWTEAGzDq9Uxw4ZC9RNpAepSChWYcmW
         Ar1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768765557; x=1769370357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngLJEmbzzfwIyJl3HgdWne+DdSWDFYCnHseYetxWc3E=;
        b=vQEf5F34i/LH3gJxeES7Kb6DJRG1vPSCbdxabb4tgJ/ZgXMa1mAU33ih2vbxnImes4
         B+ME/s8kVN5uzh3KOQ4KRCIFLn3uPV03g7JTmmasTC31Fo+95alrjQVmZVfccuzvFupI
         00j/g7kx1XTLYkc3l8u1eiK75Pcq2uxYTce8xA47YZYbSlA7fNclEEiYcuGQpu5n8Bzb
         mqELoDZIKSpV1TqJi+IQ1lfjVzOtUH/2g9lLjNQSvUff0mu3HN6HwMe0zkMlzHHtYZK+
         DtuBQ6YRw7ZJIkV2W8EOvdMFBLscwgm8WreRWMvNngXdIHaCT7Nwgjd56j/v/V1ejuWn
         R/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaD6sj70gytxgzQHUnDkaOEHgrPTPE8tLwKl/mokNcKXktFxwu44hlNJk8qDJWupjd+bqC1nuQjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLeSKoEeryaPe+YjOfsSnZuyx4i+LcxqdHU+Hkko3VPKJ4Jxb3
	1GAzlSdTz+csI8GmpnG+jJgS+DpeF+kerlE7BUoYtI+2pQn+2aCbRpphR2rb9MTD2BEg85OWjjn
	qk/9rZir2X2rknuxUriFIxaO33QvdfbI=
X-Gm-Gg: AY/fxX5BQAY/nWZCv7lhQVgKnIORt5AN9M8KNRwma+cg5eDyX+EYgS6dIImwiaPVlUb
	6RM7qMmuWytwkbAmeWm5C6LtKyB5LHU06If7G8CThbUF1ePTUYD9LdFiDMxoDnY+GdgRbUorLqu
	VJBJNbMo4cP7Y9uCofMJQXIVdCJPQb2rJrVi+hr/+exn/UZ8jXHrispfYwXVbVzgkkKtDL/54/l
	Wpz4TPHEWakydkwzLxWCcsKxlKT1yt+R+y7L7JfrWNwNBsH2hZCrYxP+CKHpdIQ1wVy+D3Er/z3
	Oy5Fom9O1V6Fj1VenXc2641JjZw2PGCAUp7G7/1g7/HQFGdXYhE8XWjQ407felnfomGWH16XO62
	OA0TJwnGnG28B
X-Received: by 2002:a05:7301:3f19:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2b6b380ec55mr3935044eec.0.1768765556660; Sun, 18 Jan 2026
 11:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Jan 2026 20:45:44 +0100
X-Gm-Features: AZwV_Qij1ytH7g1-A1PT-QCFQRqVSpKUckCbAvhQA3vEU6vow4n76J5rAgj9nXw
Message-ID: <CANiq72kvMp0KS0wXGYRiPOdNvJLoBpM45G7BHgPF_g-M9b5t_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] rust: build_assert: document and fix use with
 function arguments
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 3:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
>       rust: bits: always inline functions using build_assert with argumen=
ts
>       rust: sync: refcount: always inline functions using build_assert wi=
th arguments
>       rust: num: bounded: add missing comment for always inlined function

Applied to `rust-fixes` -- thanks everyone!

The first one I will apply it into`rust-next`.

Cheers,
Miguel

