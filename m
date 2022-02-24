Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E764C2A5D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiBXLIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 06:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiBXLIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 06:08:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CABC50464
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 03:08:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m14so3195748lfu.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 03:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q3AwHTUsABz58TbR3sxgFgdbvA3PxSarxo4vBxCOy+I=;
        b=Hd92qD6vz1bColt734QEyQZNyJ0PS77GQBqLrzA0KRc4jUOPpalM65TiSux5TDWtQn
         wzJx+vljWK4ggs3N9OyJxSi8myXkePYiPaz4SFVsnNkYEqjGz3tbLeOpDPQlbRy4sXOJ
         55dnse0CcNMmkmfURB2rZ/kuXeumAw2oT4NLCiSbGFsMrdmlYhBhmXdVEPgVohO/E2+5
         PcqUeW791VrSDyJUjBFl0ao2j6hS7M69ui9c49S2Yyo7JRQvkoiaN43GnPd2CVtqZ2XK
         qPaSA/OSnXzxREF7h97UKlt/PxcH4+Z8eodciZpT/SxQN6L5GvIEMLZMCbq/QRu4OC3g
         MAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q3AwHTUsABz58TbR3sxgFgdbvA3PxSarxo4vBxCOy+I=;
        b=ybRzuT8rMNxe70jzSp3Uu5J2QxiMOP1v1KqUV4MGqOTaODP79TkbWvVovIhy3F8XG4
         PBOlnr7GO5USfXK+Q2i4Gr5nUqusAwLDpsVGwNFGZvAhegGTTQMw4AYXxTjMdZHHI0ro
         pJzVECIxvzyiGGHhhPKAR6SyhWGhuk2gd0jEQkXjGhJkBMpQpQ3mq4RDtYIcpfkbrUf/
         r07JJfMzb7tJdeas7ceVLXWWNFr3GOB0/TKC4FEvwNZ6+suPY/RBlV+x8msXXaCQR5t8
         hRAdNAL0YQ1Qak2eXTFsxE1ujOlSWvAk3vzgJiBfn0t5NqdKxfgOmyoYqAYRxODkoEQV
         ApLA==
X-Gm-Message-State: AOAM532xUhiZYJKtlfaiTGwSw7wbf8TE2OqQh0sG620sT6aM+API4ZGo
        xVFvpRmuCBpOF/b8v5rIrVl1/zBpoGg=
X-Google-Smtp-Source: ABdhPJyP/RX4OowvPyNOGef71sZnjngAWctz61L2SEUBRUhSbDXDmaoC4kkVi/rF1MqYj2ZgWK72Cg==
X-Received: by 2002:a19:7104:0:b0:443:ab04:e161 with SMTP id m4-20020a197104000000b00443ab04e161mr1494672lfc.551.1645700879771;
        Thu, 24 Feb 2022 03:07:59 -0800 (PST)
Received: from [192.168.2.145] (109-252-137-194.dynamic.spd-mgts.ru. [109.252.137.194])
        by smtp.googlemail.com with ESMTPSA id g15sm180608lfu.309.2022.02.24.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 03:07:59 -0800 (PST)
Message-ID: <951baa84-1613-7567-4426-ffc6412994da@gmail.com>
Date:   Thu, 24 Feb 2022 14:07:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] power: supply: Use an rbtree rather than flat register
 cache
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20220222214331.1557723-1-broonie@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220222214331.1557723-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.02.2022 00:43, Mark Brown пишет:
> The smb347 has a very sparse register map (the maximum register is 0x3f but
> less than 10% of the possible registers appear to be defined) and doesn't
> have any hardware defaults specified so the sparser data structure of an
> rbtree is a better fit for it's needs than a flat cache. Since it uses I2C
> for the control interface there is no performance concern with the slightly
> more involved code so let's convert it.
> 
> This will mean we avoid any issues created by assuming that any previously
> unaccessed registers hold a value that doesn't match what's in the hardware
> (eg, an _update_bits() suppressing a write).
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/power/supply/smb347-charger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
> index d56e469043bb..1511f71f937c 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -1488,8 +1488,7 @@ static const struct regmap_config smb347_regmap = {
>  	.max_register	= SMB347_MAX_REGISTER,
>  	.volatile_reg	= smb347_volatile_reg,
>  	.readable_reg	= smb347_readable_reg,
> -	.cache_type	= REGCACHE_FLAT,
> -	.num_reg_defaults_raw = SMB347_MAX_REGISTER,
> +	.cache_type	= REGCACHE_RBTREE,

Why you removed the num_reg_defaults_raw? It was needed in order to
populate the default values on the regcache init, is it somehow
different for the REGCACHE_RBTREE? Otherwise this patch is incorrect.
