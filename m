Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F077D7190
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjJYQSh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJYQSg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 12:18:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D212F
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 09:18:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cac20789e8so9722805ad.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698250713; x=1698855513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arsy052jeDvZ80rgUaVwXGHmFjPuyeZ++dpm6EdQU54=;
        b=DWRvHHtb8RznXxlCuSaGMxuvPwz9yE7vgXHOdyDTVOJCiCD0rER18psMq0gAkHkPoF
         e4E3CCWOYBu/cS9YZzrJ0avkb3W1VlOhwmTFaBhLF7lXwfMWYs+SeeGjefQe7BtvMd6J
         dDpjw5hhgzE0KjHstkylhZUImFnzPDniMFyc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698250713; x=1698855513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arsy052jeDvZ80rgUaVwXGHmFjPuyeZ++dpm6EdQU54=;
        b=BYWCyx3qANSHw5hysN8DRXdUWBmfHixLNtbh+3aQfLsILW8iSkKdXiCFGHc2tOEHcI
         JZt/4eTR0WMkI/fgCzLLIARh8BGpxFYCP2fc5jVYnxfE1fRijhClxYYsxcb7wLTjOisf
         NJhH31uQTkpu27PrAviA+jFzJSZN3xkiHK5p6sX8v3X26S9oYH/OjX/C0M1x81nDR+dv
         lBmp//cKZWPyeOhhslYK5lkJa6Mgf4YcDV2I0RGYxP6szlxXICke9gm5YzpPNCHi++l1
         hHm3nED9L4fO/uXzQq14sFUA3r0e175PGk0X3NKva7zZzls0h36bjIIRE3HDwqZKt67V
         EclQ==
X-Gm-Message-State: AOJu0YzRsVPJZHFgQTx5zBi97wh/I97w2+fd5mN1RIFlD/dmEF+2e31y
        +DHSzeGoGFhDessCryylytUc8w==
X-Google-Smtp-Source: AGHT+IEHz2zX5L1X5ZAHX0Ckn5ujEv6EKrMfDsgQGnC0pIkIrr9N+ffoFA2gPE9N1Xa0GMZC2U4X2g==
X-Received: by 2002:a17:903:2348:b0:1bb:9e6e:a9f3 with SMTP id c8-20020a170903234800b001bb9e6ea9f3mr15207916plh.4.1698250713622;
        Wed, 25 Oct 2023 09:18:33 -0700 (PDT)
Received: from [172.20.1.11] ([12.222.71.83])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001c9d968563csm9387668plh.79.2023.10.25.09.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 09:18:33 -0700 (PDT)
Message-ID: <20dbb743-9cc0-4405-babd-024e64a0b673@linuxfoundation.org>
Date:   Wed, 25 Oct 2023 10:18:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix reference to nonexistent document
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231022185446.919363-1-vegard.nossum@oracle.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231022185446.919363-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/22/23 12:54, Vegard Nossum wrote:
> This file was renamed from .txt to .rst and left a dangling reference.
> Fix it.
> 
> Fixes: 151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---

Thank you. Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower
branch for Linux 6.7-rc1.

thanks,
-- Shuah
