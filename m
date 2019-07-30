Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D267B603
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfG3XDE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 19:03:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33599 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfG3XDE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 19:03:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so60445263qtt.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ2PVNUeTBMo5qGrNZTfNGo0I1Iz/H1TS9U/04RyUOo=;
        b=QiFE7pzYIPmIMYdHVkTLTz3L99E0Vk6JqllvHpCBW/IuiONOCl2h83cSdW95qLmzM2
         3ojX3QU9j3FHrIVxvFHeMUrgoaQhjnnpzV6s9Z0kLaZM8FPZ3tpFOUv4FcP2VehlHR/S
         k0I1X+eNSzNQdvFxxsQBIdqHAtU/OzhK7HZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ2PVNUeTBMo5qGrNZTfNGo0I1Iz/H1TS9U/04RyUOo=;
        b=gwK/u395QnGiD4NXE7+4FUqjLnqnza26m4WUpLDYaj19rhPWyTfNZ7b5lZEe/GT6xh
         6XM4npKoTSyK/xu96+qyXU1eI6vXY5CCR3ron70pqXwPvot25sPQYeIok6oTG3OlhcIs
         A9Syz+zZ6J5TRfHJaXkWvRS7aMGaKhdgPfizZ2wwMKXvkEPckfUg7NL3RWU2uKyWwcOc
         Rc5QwFYnQGTIguYeXU2dTpnzYD0YdwcH63xdaUrDPBX9PnigtlV0GrfmlMTjAkeFhKgI
         E8Mvuh1+e+IGQBeKVmaVE9gNDPpaiX6jsTa9dWVOMZaG/ViH5xXfb1eljEey6bfsmRqq
         PFZw==
X-Gm-Message-State: APjAAAUSsGf8VXtmmlnjnfZihRu61cwQJMLJNb4Du1CqDxlJUzx4i94r
        h+3TZ1LPMhPeG5mMc6SV6OfiUUchRYKorOOgbluQAA==
X-Google-Smtp-Source: APXvYqxd+3eU2l5vWwKKjq9J+zWW5+JbEvVg8eHb01WvIQAnz57XvLTIqK3oZkd1HuMThvfmnWJk15pchm1r5bCDlTA=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr84676402qth.136.1564527783234;
 Tue, 30 Jul 2019 16:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
In-Reply-To: <20190717222340.137578-4-saravanak@google.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 30 Jul 2019 16:02:37 -0700
Message-ID: <CAJMQK-jQA6aeSMmrRKDeJz+mGDsu09=ywPv+kfuo26GhQJD4Ug@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 10:23 PM Saravana Kannan <saravanak@google.com> wrote:

> -free_required_tables:
> -       _opp_table_free_required_tables(opp_table);
> -put_np:
> -       of_node_put(np);
> +       for (i = 0; i < src->required_opp_count; i++) {
> +               if (src->required_opp_tables[i])
> +                       continue;
> +
> +               req_np = of_parse_required_opp(src_opp->np, i);
> +               if (!req_np)
> +                       continue;
> +
> +               req_table = _find_table_of_opp_np(req_np);
Not yet tested in v4, but in v3:
In _find_table_of_opp_np(), there's a lockdep check:
lockdep_assert_held(&opp_table_lock);
which would lead to lockdep warnings.

Call trace:
_find_table_of_opp_np
_of_lazy_link_required_tables
dev_pm_opp_xlate_opp
