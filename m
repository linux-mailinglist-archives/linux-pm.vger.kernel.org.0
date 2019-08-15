Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E059C8F113
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfHOQmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 12:42:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42064 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbfHOQmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 12:42:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so2767376ljj.9
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2019 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOu5jqNGLaaZC402g+oIvhjilJtLc0LV6t7HtN1dbUk=;
        b=DfNG5iqsBlt0mq2+nxs01TjS7n2EVPjGj79FuBX2OjejfJpqlOLew0r7msVmODbyrQ
         Trb64IJA1Ew7yoCPZvNlIK+4aWMCEfQ4B8eL+xj6M9EsopTXo4PKfzvqF+6l89fIEMkd
         FR2fyKgd59gZiIJpQoK4pgzQvmethKEdyhlN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOu5jqNGLaaZC402g+oIvhjilJtLc0LV6t7HtN1dbUk=;
        b=kNMkbqTsyLUUOH1ivIgX+ti6W97vJGgj85tU8IuLjyORCGZbW/UKRyQrBC5URVaV4V
         0mDr7FlzkcDs2Cu1NjxLs/xnJ7HKuqtIDAAwi96cGGY5o7h4GreWPayM9fEFS5rmHTwT
         iKxPXL95QjXuoQbZILtYoh58kDBpum2ENF1lg/Nc2ELC/QNxVqcKBbwXdNb/fQRz1XeL
         ygcLYIcaZ5uLfdGRXTgL7XURkhIsxZXtYZpaDRkbwBYJnd4P/GUMWZLc+yqVe2s8k9pM
         FAibFavsaLEK1fAOsjnBHBItmLTYwYhtHP3/UpfTdUhGxzmENES6bOmxbe4/UxArnlEo
         J7Vg==
X-Gm-Message-State: APjAAAWLO7j8LueFlMQXlqf3jJXcLLx2sU5ioOk2Sy2opLsdUk0NMfuz
        xtHLl4OUt5JU426XSoyyNnFvD67eqtI=
X-Google-Smtp-Source: APXvYqzxHIGdjz1KGLuEykdv5FPxNwYfNJpxojz49Cqnot/apYuQPYgx72x5Ia8UVitYTITpcZTqCg==
X-Received: by 2002:a2e:8847:: with SMTP id z7mr3240329ljj.51.1565887338528;
        Thu, 15 Aug 2019 09:42:18 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 189sm559551lfa.0.2019.08.15.09.42.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:42:17 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id l14so2803515lje.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2019 09:42:17 -0700 (PDT)
X-Received: by 2002:a2e:8102:: with SMTP id d2mr3170073ljg.58.1565887337655;
 Thu, 15 Aug 2019 09:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190815155322.20923-1-committed@heine.so> <CA+ASDXMLms9GS5cW1yDbH8VTrXgc0VEJs9tGvTJjq41U-pt_gw@mail.gmail.com>
In-Reply-To: <CA+ASDXMLms9GS5cW1yDbH8VTrXgc0VEJs9tGvTJjq41U-pt_gw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 15 Aug 2019 09:42:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPKkEVVVML4zJN97eCEj+=R3Awjr-FRckkUovjkb9NH7w@mail.gmail.com>
Message-ID: <CA+ASDXPKkEVVVML4zJN97eCEj+=R3Awjr-FRckkUovjkb9NH7w@mail.gmail.com>
Subject: Re: [PATCH] power: supply: sbs-battery: use correct flags field
To:     Michael Nosthoff <committed@heine.so>
Cc:     linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 15, 2019 at 9:38 AM Brian Norris <briannorris@chromium.org> wrote:
> On Thu, Aug 15, 2019 at 8:53 AM Michael Nosthoff <committed@heine.so> wrote:
> > the type flag is stored in the chip->flags field not in the
> > client->flags field. This currently leads to never using the ti
> > specific function but always falling back to the general one.

Also, the key point to why it will "never be used" is that the client
(struct i2c_client) doesn't have a flag for BIT(0). See I2C_CLIENT_*
flags, which start from 0x04.

Brian
