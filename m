Return-Path: <linux-pm+bounces-21451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AFCA2A345
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABDB3A52B5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03822541D;
	Thu,  6 Feb 2025 08:36:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C922541B;
	Thu,  6 Feb 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830998; cv=none; b=rBr0Cz783PKFSxqQccPqEmK782BVfZN0ToF+7/zR1AFpNRmYRwJNa099E/hipqLyPViJRIezqLwtyIF+EJxofjmc90vcNMlsK7+POGgl6dtBNlOMbQKCnKtBjkPzjHYDxigKMyEL3DoPUxIaRcgvETRhFmuMBMdLT42PAG49m0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830998; c=relaxed/simple;
	bh=4nOk8pWLYAICpsS4N//QuGSjtR5x1pA5WzM/nQvbZ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGK+k/7w9Bev+XM7Md0k9yRQnKbGDBlSIzDIpyxCfNfpz4hdCUy6tN1UKDErUDhHZ6Rf7SQTYQ5/YKWxq4/gAP+x4/JIvCPXWN+zy1v2zM4VHhrFAbIgNTt18AA2mRvFVXHmbWRVqBivL/NvjTZjJVh9R8a+ssiTie+ImBF+rAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53f22fd6887so707142e87.2;
        Thu, 06 Feb 2025 00:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830994; x=1739435794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPNUgPEwPqReofueOuszjwUqvB1T3BtBEFEUwDkOhxg=;
        b=hl8wpvzhOuOoIANV4gPNeTrfLQMVJtuGaviZk/vRZ+Yak4m/gs0+AbVP0nIRxfOGUV
         iwM7RYRbUhNhPR5g6pF/XurQ0Nuh/vzc9Fg5qqpQ/xaERlyH6A7RgyNUKZvOGpRh0CuJ
         hjNlBEXquG3zJl+H5x8TAqiwEvhfIZ0UQd87kP/PgcDndOdTg4jPYaIH8CQPxUvK1QOU
         3duyJRCKCNDPneFdCP3yFiLCpd4YgZyjdYSjaxu+156yX24zU/8jyPn5ru/IQhvVpGcF
         NGl597WgDBXmdW/4HTSZZqEs7OURqhLkxcOq5HemYEXjY+uAoCEPsxzG0pa6oJLS+m4G
         WShQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFSfqPzeNUcbPcl7jjTJDzS59qtANyUqboL/qjiort3tnbJo7lB11A5nipB42FI24SKXJPURM77+tRHZLL77E=@vger.kernel.org, AJvYcCWVphiSAX9suQx2JsaqNgXu6Ve9rrROvn5gSNSlArzEC+6Ydf6yscKvV2URCcwcOsGROdS7Oozc8G8=@vger.kernel.org, AJvYcCWygJZtOHs09eK2yZ9tGqXNBr1wxYHax8686UuAkDb5MykTNguvclpgmRkjeMOE7AkLavy65jDbBnvU+BVv@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLg52eYmPb+0vo28FOOSRy7HaGdlD10Pmv/l6GnYCcZA6KPS5
	bKhwU+hS4qZ+3IXv6dd4TZKEnYkJ+YSaH1HG1mFI+lOGJ8shi5WrgraBdxb0
X-Gm-Gg: ASbGncsfjvCca2Tf96c1slUaFvhZM69zi9Ah6v6DG28+YMBRLNJULoGleSfHDfIbX9r
	EpHtGVFTmXyJ0/f6S/UQDG4ayfAPcVE/j6ljmnOc0RZk+ZmZXYGgyQrZvaVhnmguXep/79FZRhA
	qnA7CR7NsAbCa+ivkq1j40txjQNSGXXGF0ghCcjjZ2lnIJcgh5R5U6vhBoscJ+tMpodNL+28eLk
	/6Q1XTjw5H2+hMFuyriN8T7/WjW4Jok05OPnajjyIuJM3j0Wbpuv1LiJsFYKimDG5ZZmBpPQhcR
	eH1QBk8/Rax7ThhQGjA5oxoVvLCPuvLMqJT2zedm0gazINGa
X-Google-Smtp-Source: AGHT+IHHlnOsV7GsHFyaaCeU49S1qOu/eGnDYIC2FZ+3zEnJvAY7xGc3hEUB7g7jndxjHKVnH145VA==
X-Received: by 2002:a05:6512:1597:b0:542:2e04:e9b8 with SMTP id 2adb3069b0e04-544059fc5e8mr1942471e87.8.1738830993328;
        Thu, 06 Feb 2025 00:36:33 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441053eb06sm74019e87.29.2025.02.06.00.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 00:36:33 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307325f2436so5754201fa.0;
        Thu, 06 Feb 2025 00:36:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqyVSiVvxyFr9QFJD1mbGvydGgsQF1jpic4boOCruAmu8c8DJ7dxP6H+bTWoXn+M6uYvcXF4ptBtILP+PN7ck=@vger.kernel.org, AJvYcCVyg1T88qZv7UG5+f6f88vGOVYcS7OBzg4eBiLrDvYq3zPXDHh8oDNnK9WYO/lUUjTxWJqaXqTGC9sMzAcd@vger.kernel.org, AJvYcCWebQNhQut8+vbMHT5TDRWu3wlR5c/TORcltTSNTosMdiadpqi0tAX7qDz8U/ET7+hRZm0HPwAo6Mk=@vger.kernel.org
X-Received: by 2002:a2e:9e84:0:b0:307:dec6:e1cd with SMTP id
 38308e7fff4ca-307e091c8bbmr1713891fa.14.1738830992833; Thu, 06 Feb 2025
 00:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206083405.10286-1-algonell@gmail.com>
In-Reply-To: <20250206083405.10286-1-algonell@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 6 Feb 2025 16:36:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v65chOJmkXHaqLQxw=h0kQ9+X9p2DvA3RMAnEpqPrbFkKw@mail.gmail.com>
X-Gm-Features: AWEUYZml9YHH6v35qXnGbahPptAl23nBxSGK2Pdxe7HhbBeOk4_n9YxfNLcJupY
Message-ID: <CAGb2v65chOJmkXHaqLQxw=h0kQ9+X9p2DvA3RMAnEpqPrbFkKw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: Fix typo in dev_warn message
To: Andrew Kreimer <algonell@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 4:34=E2=80=AFPM Andrew Kreimer <algonell@gmail.com> =
wrote:
>
> There is a typo in a dev_warn message:
>  - reqested -> requested
>
> Fix it via codespell.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

