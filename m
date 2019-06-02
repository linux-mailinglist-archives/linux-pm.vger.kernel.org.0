Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA93236C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2019 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFBNqY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 09:46:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34261 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBNqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 09:46:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so226670pfc.1
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2019 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ei9fE+QoHunZ6uIfup9c91JRHQ9iAHr0WsYUOfd9Wvc=;
        b=AquIgHUrfrcg5b6PLFxSRzbLxqsdXI3v9wVqTY9BmQQq49/LtvY08VBac7haYs4XeA
         KVFDvMNbHINF4L4ulWg/+qzco6FJ6MK3fZMtqXCKGM9ltuFMjX+Ab7mN0fHejzFRw5Qv
         fQ/1HfLe58WG/QnE7grvVlIabEa9J27Mzy3MFkljJ9xnw7OeRqvHFYjyEe+3JiXA21fZ
         GCHj1699F1mF/HxuEm9huTp9XaqH0RonziM5+ebevLl3QDpXcWQFmtJcqDFZr236Taif
         bOEnPAc0OO+HLhkh+E9ei1FTK0/6UP49XwiGfUK/jZKL3/GV7YhiZZ155YGWC8oMxJjQ
         dzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ei9fE+QoHunZ6uIfup9c91JRHQ9iAHr0WsYUOfd9Wvc=;
        b=roeaAhTSeMAGZcKSQJVsG6o9c2RPVlL2bDc2DuPQQvsyEagVrdWpxQHaBxBRUrAhEQ
         u0RtrEtio10i37Iiq/zTpmCbR00TpuV71LDgr3JA/w9VHQdfyN/eybLbzp48uiOPThd5
         84HKwmryTzJWwZb+fGs3zopqzKzW1cyVaORq8EAtOZ0W0uggkPWUyjY0BDV0W9GHBu/A
         jV7jmRrt5zwjmKqDHxqxU6jAhVGNhD90TaM2rkYWKd8FG9nUjPvupLio08pqkZMJU0MZ
         Mfu0HZownk5CX3STPYQWFdcDVE4tn7lW1YqYP89+bPANRXEjsZ9lYgBSKcJyv/ff7lZs
         bfnw==
X-Gm-Message-State: APjAAAXSFy+1Gm/zmNKSF6Gj9UyIGcrEtvnpBvBZpVyDo86ef54gKuY+
        DATz6giKc2e0uDfQEHYjsOwDJM9jxbPO/VMrq9c=
X-Google-Smtp-Source: APXvYqx/MiXwB36y5K0F4cymiHywb4QU8OvWx0lN1y0cNUOyay9+jT1zrAsfr9kVQ5iT5y3GUjPweQK8/BChN7b9lKM=
X-Received: by 2002:a62:585:: with SMTP id 127mr23742381pff.231.1559483183242;
 Sun, 02 Jun 2019 06:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com> <20190601090353.GE6453@lst.de>
In-Reply-To: <20190601090353.GE6453@lst.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sun, 2 Jun 2019 22:46:12 +0900
Message-ID: <CAC5umyg_nDjtLyJM8iNF5f+YdQ6EG+G5ks-uFqu_VFiX2=e=qQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] nvme: notify thermal framework when temperature
 threshold events occur
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B46=E6=9C=881=E6=97=A5(=E5=9C=9F) 18:04 Christoph Hellwig <hch@l=
st.de>:
>
> So before we allowed userspace to get smart AEN notifications through
> uevent, and would expect userspace to clear the AEN.  I think this
> could at least potentially break existing userspace by now doing that
> in kernel space.

This change unconditionally sets NVME_SMART_CRIT_TEMPERATURE flag in
nvme_enable_aen(), it could be problematic for existing userspace.
So it's better to provide a knob to enable/disable the event notification
and we can utilize get_mode()/set_mode() in the thermal_zone_device_ops.

Other than that, this change doesn't remove ctrl->aen_result, so existing
userspace still receives NVME_AEN=3D* uevents.
