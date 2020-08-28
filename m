Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48EC25558D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 09:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgH1Hra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH1Hr2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 03:47:28 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B5C061264;
        Fri, 28 Aug 2020 00:47:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u25so212284lfm.10;
        Fri, 28 Aug 2020 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cM3CJT9ftDt6aTs3xRQ+GG6zAYjrPTl2+cVjFjcTkMQ=;
        b=QJuP2dU9nPLiBKRlazKHKpQXSmc3FoD0hpYNKIxSYi87jkEMWKYzqaffspNwFgpmo8
         cpAgYduG4CJc5Iv6RtB8eKrx2CYqypJM49zAhqEZVpOJr2As2WrO533AVaE4GHnlRVpX
         hOxGR9eysSbDr+A2uXkX2km3/RBUCdoSgAjmcYkoR49V4bLoxsLd4DC+eShUVf3lrTF2
         +EHFq74xRLZs37uMbcFtOzZZIMorE/zeiwmAxYK35/Nc1o/oH1WR0s24E+cnJdqoFhVM
         m/KIUS9oMdzGSa/2mll3oOpqTMixHhRj66QnKulGPg+q4rPsosDkqmgw47EDLRNXpEmi
         +BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cM3CJT9ftDt6aTs3xRQ+GG6zAYjrPTl2+cVjFjcTkMQ=;
        b=CckfY5Cg5fsOx/tabEcIUZjQ2JaP4qkS5hxz0wKp8N25b7FMavbkLki5/sjAPYLoYW
         0IE80AsVnj/7FCQ9MLeevIMzD226VIf+S00qHbgQuf/cNzKfc1QVFfJtvYwv9c42ed1G
         am9qndfjg0GSoZ982VFREm9AHjmywbgg3uCz9w4/ZtSJU5FKf4m+da4BEv/SyqfwkfDx
         VLJxHo5clzFv/WBEjv6iMhJQY/VBI32ow5PU87eKakbjtSa1jclcJcp8ncFVivbWXl6N
         rBbotqE5qZmX+9KJU2E5+YSV5tpijLNRRd+e/8iAhgVIoP+gF5gahmp8aHRP3xQCJubH
         KGeQ==
X-Gm-Message-State: AOAM530QfzG2UtPB/yghA69e6gHKWTiCZEZNJBjTE2UWhCbIvh9SH+C3
        1G4OMPlroyz4dMjw/wApVeo=
X-Google-Smtp-Source: ABdhPJwcpYZeInkiji0iQ5GJYarL0+TWbG/UNG+ujPcVWjnEZrpKT27KsykDmAkTuLT4PSEsXma4/g==
X-Received: by 2002:a19:102:: with SMTP id 2mr201353lfb.54.1598600846525;
        Fri, 28 Aug 2020 00:47:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id i7sm42511ljg.54.2020.08.28.00.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 00:47:25 -0700 (PDT)
Subject: Re: [PATCHv1 1/2] power: supply: smb347-charger: Drop pdata support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200826144159.353837-1-sebastian.reichel@collabora.com>
 <20200826144159.353837-2-sebastian.reichel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e41c781e-7342-dda1-3911-e2d59d827d90@gmail.com>
Date:   Fri, 28 Aug 2020 10:47:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826144159.353837-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

26.08.2020 17:41, Sebastian Reichel пишет:
> There are no platforms using the pdata support, so let's
> drop it to simplify the driver.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/power/supply/smb347-charger.c | 287 ++++++++++++++------------
>  include/linux/power/smb347-charger.h  | 114 ----------
>  2 files changed, 159 insertions(+), 242 deletions(-)
>  delete mode 100644 include/linux/power/smb347-charger.h

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>


