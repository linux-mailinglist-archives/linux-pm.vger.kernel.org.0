Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989D610B6E
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfEAQha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 12:37:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43996 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEAQha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 12:37:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id e108so593533ote.10
        for <linux-pm@vger.kernel.org>; Wed, 01 May 2019 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOL/hDvBnc7rmGBE1EnGCKIi8mO9oib6E1dFquz5h4Y=;
        b=c75jPbluZAl8W6FXzvNlmsZ0hn9bJOhswQdaPn85lp942KF8fyUY6DCj19iNroLLEA
         9KJm6G5HuxpDsdZmHjYaTomJ+WqkDyPuKIhBuHX51/zwB0DI9EuFpUay0wfb10rtuo1O
         YVbqWBBweiD1SgVsqtBjPWTnTr7rbME2IZgME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOL/hDvBnc7rmGBE1EnGCKIi8mO9oib6E1dFquz5h4Y=;
        b=G8MadkWpJjXAAZ6MtlZpQEkS8h5aJiNEIx59BeGFVO2SawfMMiQQ9Ceo3uasQX4t8w
         G3CdiblGz7GYI8cwSrPPvIfrh4oLM6Q9Zb4D4P1VI/bj5yIrrDZUi5eSXUYlBTwpjn4p
         TNh3XDHW3XfFlK8Wrmhx+uPta+k99rm2M799bU27VT/450KMPIY8L7mHvymnQEdQniY8
         2v1o97rySXxeDH7FkS2qfh+JeitsMI4INayzVwLVTTNAxdkMDTF0/oToehqJLz2s04Lh
         3oQJI8nxptjB0NYaF0Iy6Xd7+EQ/3oW1Q+rb2YGATkJDMx+YMYWgV7SJoEOE5mlgtA1Y
         GyFg==
X-Gm-Message-State: APjAAAXApdpYSR8yBKMtxbWdUDlaDUufpXKQov3lJyrxwvUgZuAcvKRr
        IKEZK5yDG9aE0ia/czyR5jodvRtFq4Q=
X-Google-Smtp-Source: APXvYqzHiNUMp17lVFNo3Nb0giZCXLx4+QkKxRBsENA1I7tC/76Nvjy1PQkmE0J/YiXgqlSiNwcwwQ==
X-Received: by 2002:a9d:4d04:: with SMTP id n4mr2650398otf.321.1556728649285;
        Wed, 01 May 2019 09:37:29 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id n185sm14348766oif.8.2019.05.01.09.37.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 09:37:28 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id r20so14085474otg.4
        for <linux-pm@vger.kernel.org>; Wed, 01 May 2019 09:37:28 -0700 (PDT)
X-Received: by 2002:a9d:30f:: with SMTP id 15mr16646743otv.236.1556728647806;
 Wed, 01 May 2019 09:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190422180754.99383-1-ncrews@chromium.org> <20190422180754.99383-2-ncrews@chromium.org>
 <22ee5583-58db-39c8-5273-34f1a4ee190d@collabora.com>
In-Reply-To: <22ee5583-58db-39c8-5273-34f1a4ee190d@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 1 May 2019 10:37:16 -0600
X-Gmail-Original-Message-ID: <CAHX4x86jGf9diGJhdBmqQskPxCFOLzVKHrP9F8LbHp-JpJSpCA@mail.gmail.com>
Message-ID: <CAHX4x86jGf9diGJhdBmqQskPxCFOLzVKHrP9F8LbHp-JpJSpCA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] power_supply: platform/chrome: wilco_ec: Add
 charging config driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, jchwong@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Enric and Sebastian,

I sent out a v8 to address Enric's nits:
https://lore.kernel.org/patchwork/patch/1065815/

Thanks,
Nick
