Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5605A3B7C8D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 06:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhF3EXH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 00:23:07 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34616 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhF3EXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 00:23:07 -0400
Received: by mail-pl1-f180.google.com with SMTP id h1so746623plt.1;
        Tue, 29 Jun 2021 21:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pNvsroCK6GcDFcekS7YXdbq6zffuEiaBrmTEkSU+Plc=;
        b=gv09EQjvkqm7ykOgs6hHYkmaF08f35auTCCvUj5jbjcpTnLWSrV4kfGakHA5uwW8qB
         x1EGbTkN5hSNeqLYpZXu4MpkCHgVd8L+BULM9pxp14YxAUTflXCq5vq7xz2EPRQKU4VF
         jxni7fIxci/IuiGs+Z0PvdVuTxs1aLHX4JAz/6b11sUuJR+8u5rK/hmUl+T/dvzJZ4Yg
         ZTupXQzZqOxnWpEefFocAfDEKzLVsWsve4BOMr3QncXdHLUaeD4FRojiiLWPSABFT41A
         QYsGnx4NgptzZYo0wvgZMHwumyVtrydVEQZUtScrfXfgZY1Ruqto/MxIll/sat6xooiP
         Sbcg==
X-Gm-Message-State: AOAM532JamdihjXnYMjm/eQGMKb+T8/5pbMb4aSaJTw3yT5DIu4KjJd+
        gJwI4AwsejeNGODQY+WJWaY=
X-Google-Smtp-Source: ABdhPJw9d0uHLCEIDUCo4TQyg/XurPk4FECuOnfL+lo3l9VmXcFLSthQ6o7JrRDeU+xI+O00wNug1Q==
X-Received: by 2002:a17:902:da8f:b029:129:fdf:f921 with SMTP id j15-20020a170902da8fb02901290fdff921mr2899184plx.72.1625026838274;
        Tue, 29 Jun 2021 21:20:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b36f:1d4c:3b33:df45? ([2601:647:4000:d7:b36f:1d4c:3b33:df45])
        by smtp.gmail.com with ESMTPSA id m16sm14818055pfo.1.2021.06.29.21.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 21:20:37 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] scsi: devinfo: add new flag BLIST_MEDIA_CHANGE
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
References: <20210628133412.1172068-1-martin.kepplinger@puri.sm>
 <20210628133412.1172068-2-martin.kepplinger@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2cc764ed-7248-0157-f8f5-755ddafa9179@acm.org>
Date:   Tue, 29 Jun 2021 21:20:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628133412.1172068-2-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/28/21 6:34 AM, Martin Kepplinger wrote:
> add a new flag for devices that issue MEDIA CHANGE unit attentions
> when actually no medium changed. Drivers can then act accordingly in
> case they need to work around it, i.e. in resume().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
