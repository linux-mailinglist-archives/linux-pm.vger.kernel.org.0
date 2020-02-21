Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8516789C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 09:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgBUItU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 03:49:20 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46378 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgBUItN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 03:49:13 -0500
Received: by mail-wr1-f52.google.com with SMTP id z7so988746wrl.13
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 00:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vdh1pOW7qqgRrMSZGB/WB2aWLiCweGEbhLNKasJ4wr0=;
        b=jrGL2CnLzDGFoHIlRin5521Kcmxa7LvZB1yE0goESpijYejm0S6mfMcvFX7EhscHs7
         5PXuPak5vILqlycvzVkQvLEWGjte+BULXNjETAWUn0SJfEFomfdTbECZdsSmHRM/byNE
         C3arPegYcRDAZE1sBnQRxE3dE0PXXewByiE+w/JkFafs0X00ckZQhxasCJI2wU4/xgey
         NFF8XEBqjRCxFcA8u2c3JHr674eGGdyd7y3dOpk4RTrD1Paypezs4pLAMQSKJPOmYWrC
         j+h3U/yScRlHdcHubr+KfSdZgbs95NdSvgMfYckkc+h4ZgDbBKVWIcGBi+vLrJ8Z6P5b
         V29A==
X-Gm-Message-State: APjAAAW1DJPJsTy/hlTMhCAU0UoIP5Uhx2hxPBmQ/IlfbT9gDCbXm+a7
        3O0zKZLiusJpM6VWyd6qsTI=
X-Google-Smtp-Source: APXvYqziC3Fp719mdNhI+e0sUbB4RI4UWaJxY4CRFHc66rKeKuKrzVRLj9qALBn+HrI1zgwlsN4LbA==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr50206866wre.58.1582274951554;
        Fri, 21 Feb 2020 00:49:11 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y139sm3077189wmd.24.2020.02.21.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 00:49:10 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:49:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: is hibernation usable?
Message-ID: <20200221084910.GM20509@dhcp22.suse.cz>
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
 <CAA25o9SCanFH3nV52BwN=7EuSUFjX=Jrd+FCiV=6ThW=beKKMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA25o9SCanFH3nV52BwN=7EuSUFjX=Jrd+FCiV=6ThW=beKKMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 20-02-20 09:38:06, Luigi Semenzato wrote:
> I was forgetting: forcing swap by eating up memory is dangerous
> because it can lead to unexpected OOM kills

Could you be more specific what you have in mind? swapoff causing the
OOM killer?

> , but you can mitigate that
> by giving the memory-eaters a higher OOM kill score.  Still, some way
> of calling try_to_free_pages() directly from user-level would be
> preferable.  I wonder if such API has been discussed.

No, there is no API to trigger the global memory reclaim. You could
start the reclaim by increasing min_free_kbytes but I wouldn't really
recommend that unless you know exactly what you are doing and also I
fail to see the point. If s2disk fails due to insufficient swap space
then how can a pro-active reclaim help in the first place?
-- 
Michal Hocko
SUSE Labs
