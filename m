Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEEB3DCB90
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 14:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhHAMQe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 08:16:34 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:44938 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhHAMQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 08:16:34 -0400
Received: by mail-lf1-f49.google.com with SMTP id a26so28345998lfr.11;
        Sun, 01 Aug 2021 05:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=I5TxH9Dz7wUsp7F7REERcqwAt5FskLKXNhEpcILLzD0=;
        b=QLf3jYzW30j/gXjeSauqPJQ3FcUrVSCQUDftBCdAA9x+4V1OzSJTBmCrtVyXU7jM43
         AgTj9DZ42e2yNIxyYj0qxfF2HR3FXrBRNR6mFt57sLQWVgKep+jUR22XcixJBAROSgJ7
         +dq6who6m+jXkMlPg41OhhkF2VbgZxkr2c5ffObCRqSbC0sh1lqdulWTSyXM1j+B+gWh
         BGPeSvBMUeY9anwXoCjQwnsvlmD/Xj57Q6k2xOw80ld/rQIWoe4fa0ogtrAC/7eahR3V
         bKvIVRdHbrCchmRqB4lQJJ+Z+6bMsB7KSKlesVfkdsTzOVLFsGDnXYOAew3f9fHj9ebd
         1d3g==
X-Gm-Message-State: AOAM533e8YjmOHIGUNXv5Zar5F+4zCjr7hHsb9XRgEXD2zeV5XPdqwPM
        shUsECjzrBRjENG53FF7KG4I0UXmy54/5A==
X-Google-Smtp-Source: ABdhPJxvjjj9Ywcb/zMes+J49NP5TwlqFvmKvP5lrfmwbDNf4EqOWvaYponIX0nXTGzXJ6yuNxajwQ==
X-Received: by 2002:ac2:52a4:: with SMTP id r4mr960270lfm.419.1627820185252;
        Sun, 01 Aug 2021 05:16:25 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c10sm621516ljn.11.2021.08.01.05.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 05:16:24 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a7so20161550ljq.11;
        Sun, 01 Aug 2021 05:16:24 -0700 (PDT)
X-Received: by 2002:a2e:321a:: with SMTP id y26mr7975789ljy.463.1627820184577;
 Sun, 01 Aug 2021 05:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210721140424.725744-1-maxime@cerno.tech> <20210721140424.725744-29-maxime@cerno.tech>
In-Reply-To: <20210721140424.725744-29-maxime@cerno.tech>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 1 Aug 2021 20:16:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v67QnD+nFG6QtLy332k_0W6kELTJEqtui_sf7Qf5nMxCmQ@mail.gmail.com>
Message-ID: <CAGb2v67QnD+nFG6QtLy332k_0W6kELTJEqtui_sf7Qf5nMxCmQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 28/54] dt-bindings: power: supply: axp20x:
 Add AXP803 compatible
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 21, 2021 at 10:05 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> The AXP803 compatible was introduced recently with a fallback to the
> AXP813, but it was never documented.
>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
