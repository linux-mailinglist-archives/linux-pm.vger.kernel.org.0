Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC412215156
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 05:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgGFDXO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jul 2020 23:23:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36499 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgGFDXO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jul 2020 23:23:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id d17so28876644ljl.3;
        Sun, 05 Jul 2020 20:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06dnrLwNeASbZqIhPWDJn9BWobfr2FTpZ2gA7IVxI1E=;
        b=l7/gW2DxxYUMemRBB4pswPj+w+Xcnywp5hMY1PUthqF4e3rVIuquT+uFBe/Gl6qNhR
         T6iPHZS56DNFNL6XxJ0kgQJX9RU3GvF3d7tfDvZk7VUhr9GVri5l8Gsd9ArrOUV8sry0
         JadBtBN3Z7dE0p2X49USNrwuqI4ZWAYTCYB/Z48lmRLsthDrxKHW4sUQLoLT/ws4UqqW
         /341NA/APJHdNzpW1DtEnpkTSHKIks/0S54o99C1p9OtpGYyfO7R0FHDPq5uSbZ/dHSy
         yzLnCBEQ83xwU1s4pUs2U60xlhBia8l8UcJ17cgchZuthxrNPYxC/wI2oJKudY2hHUkC
         Hopg==
X-Gm-Message-State: AOAM530qCIWqqD8OCucl7bpO4V07Mz/n9s4WCZDI9igG6UZZbmjMnRDE
        2HImkkl2nN9f9S5X/FCMK9FtWDiJK4w=
X-Google-Smtp-Source: ABdhPJy72ichrmFDKGa3kQroE76QnN+NBbhUWBRGUClj1SCVBESnvfNIZwB+Y5ZgyKSE81eNNRfkDg==
X-Received: by 2002:a2e:541b:: with SMTP id i27mr24289162ljb.118.1594005792103;
        Sun, 05 Jul 2020 20:23:12 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f4sm8183049lfh.38.2020.07.05.20.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 20:23:11 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g139so21747201lfd.10;
        Sun, 05 Jul 2020 20:23:11 -0700 (PDT)
X-Received: by 2002:a05:6512:d0:: with SMTP id c16mr15566442lfp.85.1594005791715;
 Sun, 05 Jul 2020 20:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200624083629.9507-1-f.suligoi@asem.it>
In-Reply-To: <20200624083629.9507-1-f.suligoi@asem.it>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 6 Jul 2020 11:23:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v65M9m3ttvcmcnkzdByNJVG0rs8dEPLtVoyr_VyO5XWC+g@mail.gmail.com>
Message-ID: <CAGb2v65M9m3ttvcmcnkzdByNJVG0rs8dEPLtVoyr_VyO5XWC+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] power: supply: axp20x_usb_power: fix spelling mistake
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 4:41 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> Fix typo: "triger" --> "trigger"
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Acked-by: Chen-Yu Tsai <wens@csie.org>
