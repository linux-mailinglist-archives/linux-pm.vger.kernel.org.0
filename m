Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BBE250CBE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHYAIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYAIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 20:08:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C42C061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 17:08:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so294752pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 17:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gCtJ6y/corMJGMSjjBXZ0t8LvIkH00RakiQX5uTiZ9I=;
        b=PZlny/UgBuwewfmYbMdujOA4X6pD4zbOcsm47Nw/99lzEbbK+qYMe3tVUixjqKcU4W
         C1W+ziouidvfkGTp4YM5d2r5RmpsRv6gz3FWFrjT1b2eGq66gD4JRLEdx/wnt/HKyy7Z
         92B83Sop5z69Yb3RGIOxaMrRHSKY35kJMq7UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gCtJ6y/corMJGMSjjBXZ0t8LvIkH00RakiQX5uTiZ9I=;
        b=DcK/XwSMjoeGjNbSGacvR6kHjDwva3vSTnL5WtQtxRgi/MOYIeq+d6ph/4u3rR+You
         BkSTi6qm0FrtG86zkwRBMJgdpXXn4smrDvNbrqYBwVEsntDr7rRd7kGhzU/NC3xciX9a
         dotNAMOjtYOISj9dKzugU6uwjtQB5B7/LEd9tMbbFl8nb7ESIDZixAbYXEGm2mWgEmLl
         rkbx3UhgZRd1OYNDKgKa+44TvRxN1lIpB9esrZbOtODRCpDQKi2d58FWo4DDhK0QUK4D
         I3XwzYuCiWu7eSxzn8SFXsm8pcKKbC3oYOhRP1kbtCkwq0cFKsZIK1W6qlCq9TPnewzu
         v8lw==
X-Gm-Message-State: AOAM530s6kAqEwcCzYXK8LsSkhGgGvHEXCjzE2/pHe0VkH3Y1rIVnQjA
        ytwvFJrNFPIET+amO5sjtvDxRhDb3Ped7g==
X-Google-Smtp-Source: ABdhPJx89StBjDDWNBIcSgKFIXxVIbai4JQfBHGbb60GQ51ySMK9yY3iM6+mfgS0ji2LOVU6ldqqwA==
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr1408421pjb.30.1598314128878;
        Mon, 24 Aug 2020 17:08:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id g5sm628179pjx.53.2020.08.24.17.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 17:08:47 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:08:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] interconnect: Show bandwidth for disabled paths as zero
 in debugfs
Message-ID: <20200825000846.GC486007@google.com>
References: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 29, 2020 at 10:50:12AM -0700, Matthias Kaehlcke wrote:
> For disabled paths the 'interconnect_summary' in debugfs currently shows
> the orginally requested bandwidths. This is confusing, since the bandwidth
> requests aren't active. Instead show the bandwidths for disabled
> paths/requests as zero.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

ping, any comments on this?
