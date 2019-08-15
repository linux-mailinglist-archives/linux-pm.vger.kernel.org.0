Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1AF8F0F3
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfHOQjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 12:39:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40479 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732401AbfHOQjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 12:39:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so2056843lff.7
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2019 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPO/yfBEfDpVVqXoM3Gy+gyjNjGD4WvkD3YTuw3EwqE=;
        b=aJXs8RUNddxNwLo+wlN3fUnYaA8q243V1tB0YJbIJqPTyxi6WVlHt8f8wjEUOlUFV1
         HmivtTAo/brwKTDhNVHIpCBVvl74hjuKB3HQrlxdiC94wgb0J3tnhl1mMOPeP6YrLo/v
         iSY9KTgPXslD2bdEnz1vDkhVmwgPQDa4lPDcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPO/yfBEfDpVVqXoM3Gy+gyjNjGD4WvkD3YTuw3EwqE=;
        b=rWuAbyOg/UWY96VORP9Svkd0WbxHaUibZcB2JGTdX4Z6PbgYAV84wxO20d23vBhPy2
         lJ9bdm0ZOAZqA07+lu2oK9RIgWifjEXgUArXBfCF8mf86e+ZiHE4MJezWX8KUSYEdpZO
         VW/f9f0PavN8eGfx3RVczWdy9lPqY2vznjDPjzO82L2ZNq4iK2pV1SpnRbAC1BfjEpio
         EzJLL4b0pOeKu1AzOZ8mxhE6EgcFeC7HOmhYu/ILohRIY7f1nci3K4ICMQh15QX7mLkP
         j3tbW7q3NXLDZXfsDfmKHI3P/aG/4iMf9b+nQnA8oIqimBOVN9fqocrO1pr4ib4IjVhl
         uG+Q==
X-Gm-Message-State: APjAAAV/ZKXrPuSSWQrFD8yKSzouqlypQ1lqKA39Dbf3XKDy2As8JoNM
        vyq14bmnkPvtUufa7nQXm49WNLRFy7w=
X-Google-Smtp-Source: APXvYqzc/OzOlwmlnLWVhUl8DCp+0NAZ/3UAZnfRG+GdhASXwvc4HbjOEgpjPDpHoknkYx1rMbwB8A==
X-Received: by 2002:ac2:4242:: with SMTP id m2mr2771096lfl.121.1565887145703;
        Thu, 15 Aug 2019 09:39:05 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u14sm554319ljd.14.2019.08.15.09.39.04
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:39:04 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h15so2760482ljg.10
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2019 09:39:04 -0700 (PDT)
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr2943148ljl.18.1565887143996;
 Thu, 15 Aug 2019 09:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190815155322.20923-1-committed@heine.so>
In-Reply-To: <20190815155322.20923-1-committed@heine.so>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 15 Aug 2019 09:38:52 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMLms9GS5cW1yDbH8VTrXgc0VEJs9tGvTJjq41U-pt_gw@mail.gmail.com>
Message-ID: <CA+ASDXMLms9GS5cW1yDbH8VTrXgc0VEJs9tGvTJjq41U-pt_gw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: sbs-battery: use correct flags field
To:     Michael Nosthoff <committed@heine.so>
Cc:     linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 15, 2019 at 8:53 AM Michael Nosthoff <committed@heine.so> wrote:
>
> the type flag is stored in the chip->flags field not in the
> client->flags field. This currently leads to never using the ti
> specific function but always falling back to the general one.

Whoops! Sorry about that. Probably could add:

Fixes: 76b16f4cdfb8 ("power: supply: sbs-battery: don't assume
MANUFACTURER_DATA formats")

and probably:

Cc: <stable@vger.kernel.org>

Also:

Reviewed-by: Brian Norris <briannorris@chromium.org>
