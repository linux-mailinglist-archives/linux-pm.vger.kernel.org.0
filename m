Return-Path: <linux-pm+bounces-45-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC17F3301
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 17:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AA12814E2
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE059141;
	Tue, 21 Nov 2023 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC42187
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 08:00:38 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b83442be42so138221b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 08:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582438; x=1701187238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lKkUJC57qzjupHlYiFFxHkD12t95lXd+zecQJk9JzE=;
        b=Q8Ryc7szUS/rmb6WWYAEaQ8YG44f5O85ClDHUhrK4E5u2XbQ2JaVXLB9M/TK3LN7wi
         R6HmU0VQV0fcGZr/SKzCrOlqq2KNf69zS0Oi/T7LOuJeJlRilPphaLvcoCug2Yl8hjev
         t++qji8sv2k9VpdCHR1Ycqb8znJ5zU2ZZ+04tQBR1yIPC9RgIb83PgzExUQYFLYs93WJ
         lr4Elv8THn6JZjSoeiZGna+V+1QlToTMtqNQgm/KRkb7OOq7BAM0Xy31PM+0Qv1hY1RL
         xfuhrljbNLV0Zi7BbAD7XzIXQ1ZkXJuHWf0rQLgrljUN98PXyrCaJAtrZg2eRvBP8Bdb
         yfrg==
X-Gm-Message-State: AOJu0YyMsNQNexQ+p2a9Dlnq6sUNvl0ddcmxRTmX7HzCd+4Rx28QMT2u
	o3Ccjj/PenI/7a8ImTe+hLU4ytn19QXlUi0jR5K6QjqL
X-Google-Smtp-Source: AGHT+IE+DMivlrJQp2cKQMMR4F5GcaplZVPfR77YUdsQhy9wYXB/SquvfXMgb9x+fNmOExcUu2dKL7A6+slaJ0Jrsdc=
X-Received: by 2002:a05:6808:3615:b0:3b6:d0f3:295c with SMTP id
 ct21-20020a056808361500b003b6d0f3295cmr9650156oib.2.1700582437895; Tue, 21
 Nov 2023 08:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120-meek-hamster-of-proficiency-00899f@nitro>
In-Reply-To: <20231120-meek-hamster-of-proficiency-00899f@nitro>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 17:00:26 +0100
Message-ID: <CAJZ5v0jk2wr9tWkKwWrrGwzSFuZDOPidgQUD1ZZ3mGPZHziQ_g@mail.gmail.com>
Subject: Re: PSA: this list has moved to new vger infra (no action required)
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 1:56=E2=80=AFAM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Hello, all:
>
> This list has been migrated to new vger infrastructure. No action is requ=
ired
> on your part and there should be no change in how you interact with this =
list.

Thank you!

