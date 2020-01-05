Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3ED130702
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAEKL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 05:11:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36487 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAEKL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 05:11:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so45118016edp.3;
        Sun, 05 Jan 2020 02:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jakc6IlwlayQOeKt2bbb+dd0QSNKcCkC9SxZmPzphJw=;
        b=LynCb2m/dN3m+BqmBHvTQO5IabBs1EJVkmviwge6oiJlzHTVrrH27NnMp+3co8On3u
         AWmyrhKBiU3oh+P3VameBjgtLO8wdQcn+/Jduun+jYR+34b8wRc7jMDgfGPcCU1aiT+K
         ubKl56AJskw0dAEDieO1rlkZM7lIvlDUlpge6czuLIsanz5olxvTWCQwaEosv6a9WbQ1
         JxezTr5SG4I7LxjEHXZfLEbFmR2cNGJ3jPEdHtg4/Er+3j0yxh52oWGxRaWMo9lxzxmV
         +eyNu37Fc0LL7AkOmOnTo3yLQinhhyo5b5IcmRB8VPaCTHgPyVSLxindyAp9MQ437BUT
         a+VA==
X-Gm-Message-State: APjAAAWzYrmvV2WESv/2orMBCdIOgs849kuQTq2MPD5aImVHQXk9mlFL
        mRUF7HyANnZBo5Qmcpaci9COKuDeBzo=
X-Google-Smtp-Source: APXvYqwup7bq6ROKfzqbYKA31bYgoXlUEmOVAmoxuPmeZmsdtMEW6zrz/blPEckkvMBIfQ730/WHMA==
X-Received: by 2002:a17:906:12cf:: with SMTP id l15mr103186080ejb.264.1578219085055;
        Sun, 05 Jan 2020 02:11:25 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id qw15sm8141621ejb.92.2020.01.05.02.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 02:11:24 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id q6so46364420wro.9;
        Sun, 05 Jan 2020 02:11:24 -0800 (PST)
X-Received: by 2002:adf:81e3:: with SMTP id 90mr96445557wra.23.1578219083951;
 Sun, 05 Jan 2020 02:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-4-samuel@sholland.org>
In-Reply-To: <20200105012416.23296-4-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 5 Jan 2020 18:11:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v67nYysrQ1OsUhv-RFWe45zwa6jLK_j3zn6gdvVzCwwCpg@mail.gmail.com>
Message-ID: <CAGb2v67nYysrQ1OsUhv-RFWe45zwa6jLK_j3zn6gdvVzCwwCpg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 3/9] power: supply: axp20x_ac_power:
 Allow offlining
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
>
> AXP803/AXP813 have a flag that enables/disables the AC power supply
> input. Allow control of this flag via the ONLINE property on those
> variants.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
