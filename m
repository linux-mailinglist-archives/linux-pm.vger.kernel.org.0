Return-Path: <linux-pm+bounces-28969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B123ADEE1A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D951BC10A7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C422E9EB4;
	Wed, 18 Jun 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G+DoVYbT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842E27E1C3
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254092; cv=none; b=T+OC+xrcixDHQzAF750ieJIU0pAqYcNA3kxPOGXRs9+U7NmA0Hfs3hx8GrHykRNVxkxwDXCh+bpJl/A+36LfhH5fVb6BU2hOB5I0pI0jdBOj8sDbW7v86liP1LGDoFRi/6VaMGFsLd8GJYztO+8NUMEhd9qpEsQiU+Bj/Jq2C74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254092; c=relaxed/simple;
	bh=yl0PcNOIcNCw+lBv442hGsxXVF1DxIoZVa0h3oivgnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbhZYxhjEl+gMed6s4KFjFcfVWgCjnCqVfV30lxePU9pQL2JQpvy3rHvUyLzfu8zjKgi65AJNCgiNlM3WoIX0BeGj+KkB2k7ft+lFbzd651g7hiD7QZ3eJXWUXsKc9lhIjO8WUBY3UGQIUbqlo7tFOiQNcRBb0nRVNzmGTKeQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G+DoVYbT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3122a63201bso6532980a91.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750254090; x=1750858890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl0PcNOIcNCw+lBv442hGsxXVF1DxIoZVa0h3oivgnQ=;
        b=G+DoVYbT7hri/6qvYZB3mhlqwubCuoHu2hBDto/BLkdS8upFBHv3YBXAoUxCrHiwja
         XzJJPhotBdKpK5HRt7uA+M6YHwpTH++9jy93lsHVKSW9kJe0FCLWN6Ui6hNpLlPczbPi
         S16c3nrcu7FPp5PaAHWfkBRJV7upkZiNztyOkrjKLW7vAD+AvhjaGzDfCO3mdCPQ3Kup
         RzJx1cWqtnlC2GLr4XVEbJ9JBRLl9bH137shewyaHMXQS61OwzgCPG6kJlaKM1+ElvpI
         ikgCwKb2OkexDrvaY0VrnorV8pEQPS4YDel/fqLVbiNdw65dguWJ/zzjBAWtUIAH91zb
         wnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254090; x=1750858890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl0PcNOIcNCw+lBv442hGsxXVF1DxIoZVa0h3oivgnQ=;
        b=AGC71KJIkgCle5EIE2sS1XO5ZKqAs9wnTNiWxhhFeED49qMQzxPNQDaqk6uN7vxYl9
         nvFxvZ0woXquMuQA1gS23A1Dw+IqUB9jWy5OtiyZtXjtr95zIGv05ov1l/powJfOlZue
         lvYBY5NPInUg8EAQHiN5JRY+fvtMjSR3DdXibyMNZsPaQiSZxiT15XPwyZXK+/omgrgZ
         ZqurNQpk+00rU7Sxc2SuLJGagwN5FieMoE3bZXccgcJiGGuZI3pytstiIpptkDsKIU2A
         8az3LBymj74QCk2pmQtGcgbk5LZY75M4Y78N7hr8Z/Uz1evLBP7SNYviRvbSIjCrKuM9
         Dt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV4fVKLlYv+Rs9E2r+oKkpicG2VIqZDlVEsXk8Oy0ATBmO0iay0vL/mcs+A2jUmiU9JT33PCRBRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmYHvdHVOuQibzZq8LMc7BktVpYmVM/EpE3Ru3Pj59FKLY/sX
	DY5gwdBRNykqKiYa6HPVye5nh+ow8PXg3/009oR1KQW7CgKYPWrsxMsYgMvrcv4vkNsSZS2BX6o
	t/+0a89uSGOqUazqpshJYS0cwWu49v0xqsxa8mk5uWw==
X-Gm-Gg: ASbGncs3RjMXl0W1s+Yi/YuyVyluN3tvpIbwEoE3sbfAY6NkW5R1SlvbmfOkDWJAUk5
	U55AKh66hU4Nx0/J8rGkRKrr6XttWKMt8rF+Hp/JFa9u4e24fSpWtb9igWNERlzYzuCWmPzdR32
	fSQA3bESH+Kf6w8E/odGuafqemgY5HZwduXjCw6OM7717l+DJuGWz2j2YzZBSeCzv9j3rLcrmNY
	w==
X-Google-Smtp-Source: AGHT+IGM3MsC055WE6RGdmTL7+xpqbeOwcWlIGInX1z822Wu3bYLUR0ECZj1HH7bbG4yZBVpGpNdgZd2k9tfvrFyAoE=
X-Received: by 2002:a17:90b:52c6:b0:311:f05b:869b with SMTP id
 98e67ed59e1d1-313f1dcbbc1mr25929568a91.30.1750254090220; Wed, 18 Jun 2025
 06:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102228eucas1p1906803f73cc004e68f281b2bdf871da3@eucas1p1.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com> <20250618-apr_14_for_sending-v5-3-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-3-27ed33ea5c6f@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 15:41:16 +0200
X-Gm-Features: AX0GCFvz_RthrqCGUMHniOjba_9qiDf9mc2HoVSIdoi-DY1O9poo5r9j_4HtbqM
Message-ID: <CAMRc=MfarMrUrdgAwa6dR2JuWooRhaqPmJeEY9H6LhVkCxf4kA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] pmdomain: thead: Instantiate GPU power sequencer
 via auxiliary bus
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:22=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> In order to support the complex power sequencing required by the TH1520
> GPU, the AON power domain driver must be responsible for initiating the
> corresponding sequencer driver. This functionality is specific to
> platforms where the GPU power sequencing hardware is controlled by the
> AON block.
>
> Extend the AON power domain driver to check for the presence of the
> "gpu-clkgen" reset in its own device tree node.
>
> If the property is found, create and register a new auxiliary device.
> This device acts as a proxy that allows the dedicated `pwrseq-thead-gpu`
> auxiliary driver to bind and take control of the sequencing logic.
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

