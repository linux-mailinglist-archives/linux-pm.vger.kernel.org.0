Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F9A5D6A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfIBVQp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 17:16:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42059 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfIBVQp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 17:16:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id f13so13613890qkm.9;
        Mon, 02 Sep 2019 14:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pf6kRO7ifbTnomTd3/bWPA70UjAWSRKoHpL8unNkk8g=;
        b=MJ2+sxKBYv56fgevVG9r/0B10FtOIvsmIC5EYT/80ioLA8/9DU/cSNpvSuWcjp+JOV
         ONibQyegXVY7x4yO3e5HeWFvF1OuNz21csEa0kMbd+EAvVYbzdha45LLl1Q0K/nIXuym
         C4hrutaruWFzqdLfldyPC29llCjg9ZKXQB/W7se/K9gzml7jURze7ZgmYEpzAIAG8JEe
         FEuVsE3S2beS5j2GiuqbcYTGR3lGgo9CEdX6JILd7FUSMNzrJqx+FVmiA+WS11n0eaaQ
         DB6aaB/o68pUE9aZ/oeBledwfd4C7Bgo1Y/Z8L1tId1QX+G02pxChIBdIsrwiLav6Ehd
         NvRQ==
X-Gm-Message-State: APjAAAX+5W5G8pGp+dp14asnaImKY7u98ekdWuyacswIADRfEsYkHs+s
        8dgQvJEYSP8oSatkyCbLoVQLgtIK9188oy+JYhY=
X-Google-Smtp-Source: APXvYqwy7H5va/4bAXkcUfSpA/SbDmlLNbYRpJqfX4B8ejokogm1ieXoll1x3qEkN/VOTl6DASAJoe2SycrHp5MqG+w=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr30124029qka.3.1567459004644;
 Mon, 02 Sep 2019 14:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190805075812.1056069-1-arnd@arndb.de> <20190902203857.zusvlv3yv5arel6y@earth.universe>
In-Reply-To: <20190902203857.zusvlv3yv5arel6y@earth.universe>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 2 Sep 2019 23:16:27 +0200
Message-ID: <CAK8P3a3uNPepYweCN9+_cQNQyiSGdidwNGL0+xhti2vm8g9O_g@mail.gmail.com>
Subject: Re: [PATCH] power: reset: make reboot-mode user selectable
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nandor Han <nandor.han@vaisala.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 2, 2019 at 10:39 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> This patch does not look good to me. Better patch would be to
> allow compiling CONFIG_REBOOT_MODE without CONFIG_OF. Obviously
> the configuration would not be useful for anything except compile
> testing, but that is also true for this patch.

Ok, I'd suggest we leave it with the bugfix you already applied then.
[caa2b55784, power: reset: nvmem-reboot-mode: add CONFIG_OF dependency]

      Arnd
