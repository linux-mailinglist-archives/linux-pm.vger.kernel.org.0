Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A225E13070B
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAEKZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 05:25:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35839 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgAEKZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 05:25:50 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so1577949edv.2;
        Sun, 05 Jan 2020 02:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgYKZTZOXD6MSAGXHEbKwV3mn3nJMEwjwWMELS2E6cM=;
        b=l+LeQqdjgzL+XeAttZe2Pm/zoMPXn11tewCS2XJw2iEIS5XgGmdEsor9v14G6eXv/0
         S7TXgKHcK31CExj9wcaPdl9rUgaqEBkYix56xJQUVhnGhJ/p3HlEFfNOQasZ1AN74Qd/
         tjJSl7f3svsgSDWi8Kh2oW3McCnRISFEM2a4ZebYeTfISZz384PnFw9gxwUUGLjxsyHf
         U9NcCl6L6/x5Mt6t44Gvf4n8F4mJ+mVG5D/8CibtmM0WpJ9b+2ttOQana3yNEPfOp3/K
         4HeyN+COhu9kr83cTIXoBcpTA3E4uRaS3P0bOgYJYNjTkGzzZqI7EnehobT0E3iKhyEZ
         HOhw==
X-Gm-Message-State: APjAAAUkRJZRrdzNjUdz3uQ8aPY06endluYDGdpxVexMOvG1pXcfVCP7
        1j8QW8waqEQ1oyPvoXzKL4UxMxn3h6I=
X-Google-Smtp-Source: APXvYqzHPF73DBiLXYrdUxfzBwQzHcDWES3LS5SrU2atexH744I9AQI/qabO9/tbyjNENl+hec44xQ==
X-Received: by 2002:a17:906:3589:: with SMTP id o9mr102219468ejb.162.1578219948405;
        Sun, 05 Jan 2020 02:25:48 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id b4sm6704246ejb.37.2020.01.05.02.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 02:25:48 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id y17so46505344wrh.5;
        Sun, 05 Jan 2020 02:25:48 -0800 (PST)
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr79126970wrx.288.1578219948118;
 Sun, 05 Jan 2020 02:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-6-samuel@sholland.org>
In-Reply-To: <20200105012416.23296-6-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 5 Jan 2020 18:25:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v66n1NqgSHS0Fg4Rcz37NV9uVT38Kd830DhFW56TposZcg@mail.gmail.com>
Message-ID: <CAGb2v66n1NqgSHS0Fg4Rcz37NV9uVT38Kd830DhFW56TposZcg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] power: supply: axp20x_usb_power: Remove unused device_node
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
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
> This member of struct axp20x_usb_power is not used anywhere.
> Remove it.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

AFAICT this could be the first patch in the series, or ordered
just after the fixes.
