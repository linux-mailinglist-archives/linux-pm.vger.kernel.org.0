Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3992A6FC434
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjEIKtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 06:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjEIKtX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 06:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFA42D40
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683629321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dF4wrvhs6iT3BX94cowoO6l8gewYlbavImEx7UJFnUE=;
        b=e1CI1b+NoCHb4w1pWFvbqLR864cO04lrPniSSBdD//1HdhlaLTa72XFzURa5tzsalTv+s5
        JxOTxpsSC8kUoZuaNjlU+HYcPd1osuTi2+ECwlXIuUjYRt/g5t9DSXTXGQj1xKknVc9smP
        FLFOi5GnyEVFL06Ic61rlZyJsZScXXA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-k0MnklaGMFih3G3LhAszKA-1; Tue, 09 May 2023 06:48:40 -0400
X-MC-Unique: k0MnklaGMFih3G3LhAszKA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a348facbbso704924066b.1
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 03:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683629318; x=1686221318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dF4wrvhs6iT3BX94cowoO6l8gewYlbavImEx7UJFnUE=;
        b=apY9oo8TWLyEpYh7yZwbPccTfCQblZTpkltevhAevdXXTVz1VQcFqskav6x4YQgK+P
         dJzgx0JcBx0dt5F8aowQVBTF4QwS9LfAmVC4Or6ustXxsY9Oz3hZ4cRGNrfmLhVC6qvT
         i0+/qnog3erx7/1gkOUqhRyzrjfhUJMGR0a17xsgod7yrir8kxY8hJ6lHu55upMOYTHS
         lMvDa7z1ZFrp1bc9a4RhmN/PDr86hMqq9lYGLxVHjUhPcfcv6oi9bkJVqakN3IQgHyuB
         1LmlxxdACjqCd91O1+rwNSl0oOpUZbR9PGao1wgb0bfjJPyDsc5rF6Y5DhWnFQAo4BU/
         irTQ==
X-Gm-Message-State: AC+VfDwAZahHtHp4/o9di9U0XMh/Cow+ZOhT+yTnoavT5MRV225wOwjO
        IEdJ9LaOh4ZTFGhXqwG8xaNFoWwcFmVH+iFfFJ7VeKsXMfvPAQ/Suag3AQgLTUPvVAQba0GivK3
        5nuEJfZVZvGb69gvt7s+HvuSA/rg=
X-Received: by 2002:a17:907:2daa:b0:94e:dbf7:2dfe with SMTP id gt42-20020a1709072daa00b0094edbf72dfemr12770043ejc.11.1683629318329;
        Tue, 09 May 2023 03:48:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UYk8G9iGMCs7FkOKovnaKAcv1qX2cMdbmvvOiTmwjKoD1/KlzF6r+LcHuVwMIG5PDJk6ZSg==
X-Received: by 2002:a17:907:2daa:b0:94e:dbf7:2dfe with SMTP id gt42-20020a1709072daa00b0094edbf72dfemr12770030ejc.11.1683629317990;
        Tue, 09 May 2023 03:48:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i24-20020a1709067a5800b00965aee5be9asm1183350ejo.170.2023.05.09.03.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 03:48:37 -0700 (PDT)
Message-ID: <48e4b8b3-29fb-4d97-db1d-446c00403c80@redhat.com>
Date:   Tue, 9 May 2023 12:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/1] power: supply: axp288_charger: Use alt usb-id extcon
 on some x86 android tablets
Content-Language: en-US, nl
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20230401150651.597155-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230401150651.597155-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 4/1/23 17:06, Hans de Goede wrote:
> Hi Sebastian,
> 
> This patch used to be part of a patch set with 2 ACPI patches which
> introduce the acpi_quirk_skip_gpio_event_handlers() which this patch
> depends on.
> 
> Rafael has picked up the 2 ACPI patches and submitted them to Linus
> as fixes for this cycle:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5adc409340b1fc82bc1175e602d14ac82ac685e3
> 
> But this patch was not picked up.
> 
> So I'm resubmitting this patch hereby for direct inclusion into
> your linux-power-supply tree.
> 
> Note this relies on commit 5adc409340b1 ("ACPI: x86: Introduce an
> acpi_quirk_skip_gpio_event_handlers() helper") which is in Linus
> tree, but only in v6.3-rc3 and later.

Thank you for merging a bunch of my patches yesterday.

It looks like this one has fallen through the cracks though ?

Ideally this would go to 6.4 as a fix (as mentioned above the
patch it depends on has landed in v6.3-rc3).

Regards,

Hans





> Hans de Goede (1):
>   power: supply: axp288_charger: Use alt usb-id extcon on some x86
>     android tablets
> 
>  drivers/power/supply/axp288_charger.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

