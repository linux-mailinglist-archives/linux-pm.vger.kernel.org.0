Return-Path: <linux-pm+bounces-34448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B599B52C81
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A66582FBF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FDC2E7BA0;
	Thu, 11 Sep 2025 09:02:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F62E7187
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581326; cv=none; b=TTrxCIaTsBmEdNEx2621t/PzLZNBVkQH3BMWYnuX7bhw895ajIS2ggY3WVUz6L6XJn0LyuGhJZRpz/q90lIU3/eN4aqjDLpJMTZA5wo1XSchq/f0vb7qVhWiGgmA66w8te6lBsMfPTfI80OluZiLaMm0gpQm4Fg27ujxBPmDwn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581326; c=relaxed/simple;
	bh=ICmlsaYKwcvKV+REXNGRI/oYch0wW2QWDCRm+WbsTt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HO1GvWNiTaMtRKk6Y4ZHmR78lWWhu9X3APDSmomgTmpwp+9HDVXC2T0N6vfI9hJuEwxOIYIuU4AOxQDG8wYYra9/MzNQlegGVE9S8bZk38SMGaBMLqB0y4IXL4SVtPpkFmCe+eq6m8q5q/d5W7YLgxQ5b+7CpXP+djJJ++lhTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-544af5b745cso323127e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 02:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757581323; x=1758186123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma/6vP6cw0Ynsztpbgjyb4FEYEjAJYKzRW150ld1Q7A=;
        b=nyUxxnkVFQHt9Y8mEBAdUUMO4AftwJmcSBDpbMs6rlBpwS53sGb6isa7PLhuhTBQRe
         eJHeqVJOoiKPUOpv1NrpcjNk0zOZwmNx5JrY/GP/+3FdsPSuP6zllNMVrs/yqw9N+24I
         mH9lzSrEEv/n5eo7Hv4epd2Do/hX5vqZpmHx8mcu+JOxngho1LLmpaX2pZfi1w69P08N
         r1pYM0CeRsf6eTyUxSX+1+KCBQAhJg6MgYV89llnrCB5cxV3uBk4DIEFWsn/HDOeKnpv
         j4UBsr3x57TE4kHzKz8UXyvUEAAHTF49QojEmkwdZnjmaKXu7E3OgCrcI+FEty2FN8M0
         Iz/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmaEn0vlwyp0plEITxBvry1ykw1bw7RtzepPyYBV39ua9QOD43T48MDuvBcMVfHZF0YkV2/JCEYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcdOk0DWjilvKGrcssHfsc4eG9Cnp5dqM6UEqmmoGuSM6He/7
	d+0BMTsIT+H3F1Rz8HgndejVhPuh0b1ycYpObeO2IMT6Sl62UHFx8+kKz1BrlaBM
X-Gm-Gg: ASbGncsz28Xnif6bMpbPL70FVzgEiIH122trs06hpn4HGylUnj5X+2/EoRuUEWF6IDJ
	qevgGo2oYg05cfT+YBds03HQ6kUnAjAcpdz/o1JXckoo8aAmLtciZYjKZFI8OZo9c1+ro4Abhpf
	Qtta/bDLqgVQJSKsO+UF27DQFBn2xtdf5BxSeEGOBN4ZW7ncKPhrQF5cohUeO4c2ZqjnbTrLtw2
	j28alIciNlmylmKQehbusdws6YWRX7uBUStdRuasPqMhljMWtEobfNGV+KEZfP/52zrN3WxRnz8
	JUxUZxMNEzc5fAr3gTg8e6G7UvboGUL3XWXjecHLc432e8orbyNbpe85NfLzl+gCaIT5xNESNQ0
	n69vX8/iEH2/5uin9Rqs1EFPf5FcRW713+mlpTcxMRCgQ1MU8FEmQ3gQ+w1SH
X-Google-Smtp-Source: AGHT+IGh1KVKupz6BIA2wEowZmwdAyuJAJuxJ9IWJg8HiPxEP+ie6fG7nGnjayhCHOufRI6k/eSu6A==
X-Received: by 2002:a67:e7cc:0:b0:51c:77b:2999 with SMTP id ada2fe7eead31-53d1aead9a3mr6366925137.2.1757581323114;
        Thu, 11 Sep 2025 02:02:03 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55375d5bd54sm218515137.14.2025.09.11.02.02.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:02:02 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-890190d9f89so293980241.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 02:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyILFFtSNElRFYK5F63tlQMcpq/FEgZibT14Mhdq8NP8eBAVgaqS3FibFDIWx5k/BePWL5VjWtBg==@vger.kernel.org
X-Received: by 2002:a05:6102:3e0b:b0:522:1013:cace with SMTP id
 ada2fe7eead31-53d1c2e1cbamr6471994137.10.1757581321304; Thu, 11 Sep 2025
 02:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <20250909111130.132976-4-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-4-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 11:01:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
X-Gm-Features: AS18NWB_6gJmqKrqPl8hBI-saW-lKUrGeAKCkd2NAqUJ0GfWChjmTWPU1ec2v1s
Message-ID: <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pmdomain: renesas: rcar-sysc: Don't keep unused PM
 domains powered-on
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Tue, 9 Sept 2025 at 13:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The recent changes to genpd makes a genpd OF provider that is powered-on at
> initialization to stay powered-on, until the ->sync_state() callback is
> invoked for it.
>
> This may not happen at all, if we wait for a consumer device to be probed,
> leading to wasting energy. There are ways to enforce the ->sync_state()
> callback to be invoked, through sysfs or via the probe-defer-timeout, but
> none of them in its current form are a good fit for rcar-sysc PM domains.
>
> Let's therefore opt-out from this behaviour of genpd for now, by using the
> GENPD_FLAG_NO_STAY_ON.
>
> Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -241,6 +241,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
>                 }
>         }
>
> +       genpd->flags |= GENPD_FLAG_NO_STAY_ON;

So this applies to all PM Domains.  While this doesn't hurt, perhaps it
should not be set for always-on domains, and thus moved up, to become
an "else" branch in the "if/else if/..."-logic handling always-on
domains at the top of the function?

This applies to rar-gen4-sysc.c, too.

>         genpd->power_off = rcar_sysc_pd_power_off;
>         genpd->power_on = rcar_sysc_pd_power_on;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

