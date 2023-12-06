Return-Path: <linux-pm+bounces-726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98089806402
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 02:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B4A282078
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF5807;
	Wed,  6 Dec 2023 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1MLO4n3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBB194
	for <linux-pm@vger.kernel.org>; Tue,  5 Dec 2023 17:20:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso2997a12.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Dec 2023 17:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701825627; x=1702430427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e6HKJAOBlM7RBaBxZJTZJBR5HIXv1/xwkFWn2KvL2U=;
        b=G1MLO4n3We5ST7XVyVRQH5l7kPVb+PNi3SMITT1ejHZ2LFkrXlASh1bSEkdRm2X4Ft
         YngynDBIWZFW+avHn7VBs1aO7P10RpeScweooDZ5SDzqX0dqj7tX/3Pnjul8mlwGj0Zw
         kckHnNm5K0NK/IYCO82+m2AfwuSs1hPDTkotiZoajJdIcjsDmKQJ3CAzKTvke5oZH6sV
         JhgfLrNrOS1L2U/yE78IPgnN1lkd/piNtKuX4nXBaIjmtbB4BXjHcJz37mRilTa/3EE6
         cYKjaPcQuavHKfujEPuxLFr6sho9JyP1hIs2+664z1JAng667sWtC6fMCpfZXpfUItnR
         vWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701825627; x=1702430427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e6HKJAOBlM7RBaBxZJTZJBR5HIXv1/xwkFWn2KvL2U=;
        b=OibCzX4bJWDcRWNEdgDjBc5Up0A4ojM8y/ojyHTohB4SWlumZbU0HllU/hhzo2kjoL
         hQVOUzfHgLcuQP2WClWVUX36XpajDUdDCgU7B0t3L7j2jGvA/TlRwMyJDIwV248Rbw3k
         XLeVLM202Pp07y9sOEp6S8CyCOoEKutX6t9k9Ggd06+j7celKK2zMAb7HY1VKUFEtG62
         4OSp9lFNwp7+XxTSkHSOx8FNWkOAVoclTx3MODm0b9OfbtUC0+C/UKQhct9wlD5w6Rs1
         MBE/Rk6fYhvkrrUNp+1k9jARWZYqYyfATLcE8SQwyj6hphSYr/zdHml3EjnMZSPodpZm
         M0kQ==
X-Gm-Message-State: AOJu0YzjoTD7bycD9kRyw7tmEufst1YPCz1xmxKR/1xFzyJHW8PuaBKI
	/rggahVoQi7TVBqyW7SfKD5K7f4EO1LIogDJXT5Isg==
X-Google-Smtp-Source: AGHT+IH6ze5+GrRW43I2juEb9LY8A3zNcTx1dV7WkAhnVYtpXJuIlWRKuZksEimpHZUhS75quQcqnccdAB0vavQnjIM=
X-Received: by 2002:a50:9f89:0:b0:54b:bf08:a95f with SMTP id
 c9-20020a509f89000000b0054bbf08a95fmr42502edf.6.1701825626583; Tue, 05 Dec
 2023 17:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com> <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org>
In-Reply-To: <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org>
From: Radu Solea <radusolea@google.com>
Date: Tue, 5 Dec 2023 17:20:14 -0800
Message-ID: <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 4:20=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/11/2023 00:40, Radu Solea wrote:
> > Some thermal zones are bus connected and slow to resume, thus
> > delaying actions which depend on completion of PM_POST_SUSPEND.
> > Add optional execution path to resume thermal zones on the system
> > unbounded workqueue.
> >
> > Signed-off-by: Radu Solea <radusolea@google.com>
> > ---
>
> This async change may have a lot of hidden implications.
>
> Could you elaborate more the issue and how the async will fix the problem=
?
>
> If you have a platform being slow to resume, can you provide numbers
> with and without this option?
>
> Thanks
>    -- D.
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

In multicore systems PM_POST_SUSPEND is executed on a single core.
Any work done in the notification chain delays all subsequent actions
in the chain with respect to system time, including the completion of
the write() to /sys/power/state.
I didn't include numbers from my system since they are likely
irrelevant for other systems out there. The particular number I'm
chasing is ~50ms.
This comes from having on-board peripherals as thermal zones, they
execute async and significantly slower than the main core, add a/d
conversions and bus delays to that and it's easy to see those numbers.
Making the entire sequence synchronous to itself and async to
PM_POST_SUSPEND isn't that much of a change, it allows the sequence to
run on any core with spare cycles delayed with whatever the system
unbounded queue load is at the time.
(on my target system) I've seen consistent time gains (those same
50ms) to PM_POST_SUSPEND completion with this sequence actually
completing before the chain finishes, this will vary from integration
to integration.

Thank you,
Radu.

