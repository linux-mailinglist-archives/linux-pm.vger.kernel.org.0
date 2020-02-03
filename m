Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB7150801
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBCOGN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 09:06:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44836 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbgBCOGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 09:06:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so7618148pfb.11;
        Mon, 03 Feb 2020 06:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CS2tHMMmwWOGzePqxzgdPTa5lsxAUAamlNGJOc+D0IA=;
        b=AtK9U476+hxcz9fn/khaRNV3/2KDRy4+1499RFByrJYG0AmivrbfQ/FHr2++iEzh/Q
         baZYgACLmglqjfnPxDWmXRvvSQQSguehckcfRZ+zVGep32t7AWJI/pyW4fzBb08Xw6XY
         E2XYPekZCSnPouMZSSJppCIfsDHMEN58Haq3lvGQKSuMkBmsTsW6rRKUQUoFD5i4vYzO
         udZXqE+yRVKCu0tHLqpPfpww5UQCAoOeqhvK36XKM+xvUSx3t/h1lSQxlJVjzctjUY+G
         HeuoFir+1bqR6Ky2TUG5XJzCTdQPeumTyHYeCJ3jTiQMtVodxUVmLZ13FBuL0l57efs0
         1vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CS2tHMMmwWOGzePqxzgdPTa5lsxAUAamlNGJOc+D0IA=;
        b=IoMhPECTIoWT7rqwX/DyyhZQvepJDw/GZOf95X4EtOelzZwMc02t50Szc10MKR7Wph
         SOGw2M4hlmQlXeDbzt2jea2UtMIHapXy//1Tfg7D3VSpeg5IbyfPCCCvia+iof/A16ae
         PnKG8of+jjaQVNNGhtH+tDCAL25eBd+DehC2KqKRSMsuwmveYA4AlbN21SXNKoHJVWPN
         QJySglbaOHsyUYA5NGQx+R81AgstD39wBU0/ugkwJK4kVrnbSzboQlIErkx/6/wQAwUL
         w0CdSVYmCqVQnszeIn6pmSpEG69bg5PRkjD+hzQaVkgmX1M93vSCHh4KOGsu0GwjvinL
         VMwQ==
X-Gm-Message-State: APjAAAVU0+jwlAXW/s86xicxHHepAmG5zkzBihJ00xk4Put3DWsMf3A0
        J3tQ1DmTzeBtv/No4z/1Zeg=
X-Google-Smtp-Source: APXvYqzGt0xGwfFWJkv3y58xVYNWirffM9sy+SoulITwlj9fap21bhYbnm0CyO3fv9nJNLax+jo/Nw==
X-Received: by 2002:a63:348c:: with SMTP id b134mr24489423pga.197.1580738772265;
        Mon, 03 Feb 2020 06:06:12 -0800 (PST)
Received: from mail.google.com ([2408:84e1:66:9abe:a0b7:8d02:f456:6577])
        by smtp.gmail.com with ESMTPSA id q12sm20630847pfh.158.2020.02.03.06.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 06:06:11 -0800 (PST)
Date:   Mon, 3 Feb 2020 22:05:21 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vinod Koul <vkoul@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix build error for cpu-idle-cooling.rst
 and client.rst
Message-ID: <20200203140521.v3rxpvhqjxpvov3n@mail.google.com>
References: <20200201062521.7296-1-changbin.du@gmail.com>
 <6d6bfd1d-dd22-8999-fc73-3cf12dbb3a98@infradead.org>
 <20200201125914.lpejzlgxazuu4i6f@mail.google.com>
 <4ca88e39-7dcd-1709-96cc-4fb324715835@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca88e39-7dcd-1709-96cc-4fb324715835@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 01, 2020 at 08:17:27AM -0800, Randy Dunlap wrote:
> On 2/1/20 4:59 AM, Changbin Du wrote:
> > Hi,
> > On Fri, Jan 31, 2020 at 10:33:30PM -0800, Randy Dunlap wrote:
> >> On 1/31/20 10:25 PM, Changbin Du wrote:
> >>> This fixed some errors and warnings in cpu-idle-cooling.rst and client.rst.
> >>>
> >>> Sphinx parallel build error:
> >>> docutils.utils.SystemMessage: ...Documentation/driver-api/thermal/cpu-idle-cooling.rst:96: (SEVERE/4) Unexpected section title.
> >>>
> >>> Sphinx parallel build error:
> >>> docutils.utils.SystemMessage: ...Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
> >>>
> >>> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >>
> >> Hi,
> >> This commit has been merged:
> >> commit fe27f13d677ccd826386094df6977cfbc13ccf5e
> >> Author: Randy Dunlap <rdunlap@infradead.org>
> >> Date:   Mon Jan 20 14:33:16 2020 -0800
> >>
> >>     Documentation: cpu-idle-cooling: fix a SEVERE docs build failure
> >>
> >> Feel free to send patches against current Linus git tree.
> >>
> > Seems it is not in Linus's tree yet. But is it in Jonathan's tree now? I could
> > rebase to the doc tree instead.
> > 
> >> Thanks.
> 
> Hm, now I am confused.  I cannot find it at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> 
> but in my local clone of that git tree, I can do
> $ git show fe27f13d677ccd826386094df6977cfbc13ccf5e
> and see it.
>
I have rebased my patch to Linus's tree which already has Randy's fix. Please
check v2. Thanks.

> 
> -- 
> ~Randy
> 

-- 
Cheers,
Changbin Du
