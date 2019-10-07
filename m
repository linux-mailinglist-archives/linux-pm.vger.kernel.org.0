Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55788CEA1B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJGRHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 13:07:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37681 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfJGRHt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 13:07:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id e15so5384988qtr.4
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2K7rXlp5X/h8ftzby/KietV7LryoE7u4vg9KSTfQIbs=;
        b=CKT9ySkTfIiYroy6J96o8UPUxe9+acVcRANOXINUzq+2CkAZkvPJeGXo+CBDeO9dI0
         oddOFvsguco+H0TeBx3nmOp2HP5Rc3r7TdyB9Mt00WmgxI91B54LmDA7j+ZRXUfE62cY
         wvWoVdMCX6jS0MV+TAbmr6AEy4++UXAcPsnEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K7rXlp5X/h8ftzby/KietV7LryoE7u4vg9KSTfQIbs=;
        b=mWdjoJ+P8oFAmp127DC6tQcTTaWKW1xybaiXGxjACiEkohCK6NSjkchJs7+9rusqfv
         UYtQuYisMNQAyGqREz1L7F9eY/xT+TngkHUqS4n0QSmNSlRAfmyC8IRptN4fxGPHI9HD
         dzGlQ8qq0IDA/G+M4yIuvygc6q1esGp+37nI9vru0BXiUTQqHPqwtqiSyfGtRGogE1Rc
         Xz80+XWTaBAhP1TNn3S4i6H9AXF+YP0iaTGeqJyNnJ/8diEeNdwVqZQj9CDGNVpXzS0X
         Qd6EycZ9AUIxuFnX3JXsLxqe6dAPhlmayf3XE/fmMGjt+eWkkLBigL9b4/21a5T3oNlL
         u9mQ==
X-Gm-Message-State: APjAAAUWtdNTqMZ8K/ODjcGvDJFPQ23VHlkPNmxST4f+lxmGV/8XtAR+
        imcxB0xMgtaFHz29dJLq/JO8SKRJR45Hzcx+6W2i0A==
X-Google-Smtp-Source: APXvYqyZ2JVdHT9qz9I8PsmKucNM8Is44BfBqxJCxK98WAy+0lfyTExVu/81vESxndFenTE4mepOqqFvEjRyGUIa0aY=
X-Received: by 2002:a0c:edc2:: with SMTP id i2mr27888828qvr.229.1570468068020;
 Mon, 07 Oct 2019 10:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190910075907.132200-1-hsinyi@chromium.org>
In-Reply-To: <20190910075907.132200-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 7 Oct 2019 10:07:22 -0700
Message-ID: <CAJMQK-jawP2+Ba0AkquqU16vVnq_yGJN=Bepk7kLRusp_zdq2A@mail.gmail.com>
Subject: Re: [PATCH] thermal-generic-adc: Silent error message for EPROBE_DEFER
To:     Eduardo Valentin <edubezval@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 10, 2019 at 12:59 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> If devm_iio_channel_get() or devm_thermal_zone_of_sensor_register()
> fail with EPROBE_DEFER, we shouldn't print an error message, as the
> device will be probed again later.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Ping on the thread. Any suggestion for this patch?
Thanks
