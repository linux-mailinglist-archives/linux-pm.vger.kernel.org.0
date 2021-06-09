Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675C83A1130
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 12:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhFIKfw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 06:35:52 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56130 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbhFIKft (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 06:35:49 -0400
Received: by mail-wm1-f43.google.com with SMTP id g204so3680140wmf.5;
        Wed, 09 Jun 2021 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P4cgH8oFymIFjZTH3CHg2wo7SV8NvJbv1pufBgRVFXk=;
        b=fJrCJoyOKHZjU+dTpb3gNSifhKoIxDOiat0mP189Biw6SHXXSHnkSbHA0/aafJSl59
         9w5U0oafwcr+uR9MeWt7CiPuNdVYiH0I85nNmjWKlUiu64KDZ6PSfOEACtBR5r7XQoBN
         nBmZH3sP6AbX8wMgehYY9ouM433woTDi/X3mdV4AaEHtB2fbg1h6KUDJbbd79Z4uw4oS
         bu8h2khsp1Efg3G8nBk8OBv7+EnSyD16CgsQnzqENZDLFv/dY9ZcbxRi/ptpPWktuSu4
         sVrISSUR4qtLtMXiNT1QqTrOqz+Iy29Kf/h7FNPToi/GUDxOP9B5Pn3ZDko6TeNr2WXT
         ZYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P4cgH8oFymIFjZTH3CHg2wo7SV8NvJbv1pufBgRVFXk=;
        b=hoJ4tsrMVWyaVcAbjmMULjelf1jUIPpjc/BxP39IFDdYJ8GADKZiOF5Gd9RXPcnHrv
         juvi8Mu5zOzU2+NJ22LRTXQoe1tPrTKC1YFnY+WBAIDNuWkkL3wsvs1GtTU5Zszq1as8
         si656C1rHkh6iD8ALIkkIkatKPH3TERxO205mkGZ/fLYY5wPMtvxnS60p16OEeYePceY
         1b6qCXHOG6bB60YLGEH8Drdmvn2aWhmQb5/oHOUb4G+ugG5eerJm80AvB9zZUyuitRto
         pZ+ezfRGnkXBcmp+00Zf/hFtaaqUEzTt3NmH4VnN6+K8FEUoCHQT48ytq5Gug3teJbcr
         PdLA==
X-Gm-Message-State: AOAM530qRaD7iP82RGOi3cbwelSWOk3C1hsm4JETcSmP6/CfNZ6XIAdV
        gOrs56/VPNcUvMKOnqZ5p7k=
X-Google-Smtp-Source: ABdhPJzOGsdifqwK0g5kUKqGwEkkGQ19ZrnAjS9qtb3yoDxuCUA0eZInD75LQ43k8MwVMcPRw/d9Zw==
X-Received: by 2002:a1c:9a84:: with SMTP id c126mr26723738wme.160.1623234761358;
        Wed, 09 Jun 2021 03:32:41 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id e17sm26176307wre.79.2021.06.09.03.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:32:40 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] thermal: mediatek: Relocate driver to mediatek
 folder
To:     Ben Tseng <ben.tseng@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>
References: <20210603081806.21154-1-ben.tseng@mediatek.com>
 <20210603081806.21154-2-ben.tseng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1157f945-f0c8-5ac6-1512-71adc72b514d@gmail.com>
Date:   Wed, 9 Jun 2021 12:32:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603081806.21154-2-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 03/06/2021 10:18, Ben Tseng wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add Mediatek proprietary folder to upstream more thermal zone and cooler
> drivers. Relocate the original thermal controller driver to it and rename
> as soc_temp.c to show its purpose more clearly.
> 
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/Kconfig             |   14 +-
>  drivers/thermal/Makefile            |    2 +-
>  drivers/thermal/mediatek/Kconfig    |   23 +
>  drivers/thermal/mediatek/Makefile   |    1 +
>  drivers/thermal/mediatek/soc_temp.c | 1127 +++++++++++++++++++++++++++++++++++
>  drivers/thermal/mtk_thermal.c       | 1127 -----------------------------------

I suppose that there is no functional change. Then better put that in the commit
message or use "git mv" to get a better readable diff.

Regards,
Matthias
