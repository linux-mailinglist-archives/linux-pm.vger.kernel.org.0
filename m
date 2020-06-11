Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B4A1F6A62
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFKOz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jun 2020 10:55:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44736 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKOz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2020 10:55:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id w15so3660673lfe.11;
        Thu, 11 Jun 2020 07:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tG64BUJ8TS5taZg0hL83hvWeRis47PfXL8DPqNHCXxs=;
        b=OLGuwP2CF7bZFkOiORcLAQoD8LxaWs33FqlC6HwRj/wKwRGjYUmnhCBfe8XI8yVkST
         /q71OzWG+SXD1QCtxXKa5Nwi67ahQ6w48mmdVDn/oVuxBEOdRWKkauxJaueXmlD3PRBN
         0gy9v9UCbletZUgbesUH3/K+2ypDa2lY0aM1buqeP9PSsJ8u2UaUWz0Y4R6p23PQ/aJY
         cL33T4phHwvHRPL2MBxKFDlOqPhdFlA237PsPpwh4gGMjXHZL5I5hCcYz8SOKBdF0V2K
         RLZm3t4X/JIbRXUYAzHqCLWQCsvSnNmchZSMt9pKNlYrs+ODFBtYfwEf8o9VVTTIItrs
         llJg==
X-Gm-Message-State: AOAM533lMhXrHWdBKuiu9uxwMG3FAZtIXMoCFGvVdsjEDTDfWxKPQVmw
        PPRYwuBoEtSYbi38c6FRuCVP7O1ZNnM=
X-Google-Smtp-Source: ABdhPJwejNPn8b2gu/doPN0PjZLXAZa8cOcqJeH5Z9QKV8/y5Hqe8mos8aIMBwkmj98yAh2/93RD/w==
X-Received: by 2002:ac2:4ac2:: with SMTP id m2mr2721923lfp.94.1591887354536;
        Thu, 11 Jun 2020 07:55:54 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y12sm769380ljh.79.2020.06.11.07.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:55:54 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id c12so3664876lfc.10;
        Thu, 11 Jun 2020 07:55:54 -0700 (PDT)
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr4264517lfq.4.1591887353884;
 Thu, 11 Jun 2020 07:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200609224524.108092-1-iamkeyur96@gmail.com> <20200609225035.108435-1-iamkeyur96@gmail.com>
In-Reply-To: <20200609225035.108435-1-iamkeyur96@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 11 Jun 2020 22:55:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v64mEhd8d-=+bt=Di=L4+kyt6VLyp2ZbOxGnDoiV09iJ+g@mail.gmail.com>
Message-ID: <CAGb2v64mEhd8d-=+bt=Di=L4+kyt6VLyp2ZbOxGnDoiV09iJ+g@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: axp20x_usb_power: fix spelling mistake
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 10, 2020 at 6:50 AM Keyur Patel <iamkeyur96@gmail.com> wrote:
>
> Fix typo: "triger" --> "trigger"
>
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
