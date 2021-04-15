Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C835FFDA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 04:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhDOCIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 22:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDOCIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 22:08:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D41AC061756
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 19:08:10 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id h13so5087735qka.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 19:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JqLpHGjz8FBfsB+oiUFw3oGbHf8VhZlWw288yxsMYis=;
        b=VWtNrScHvqsJ9+VBK5repCCDNFK+b8SyNiz6DsD5iU9MSf/SFWFWvqbVIcZomSDRZZ
         fpcJbGUNy3WM6RSbnJORxrGHXHdL2rSYUeRWogG7bWoAbN3H7wBDofgFnPCEcW2AErm5
         MuoGr5C3jHjbGDLFaV6P0Ep7TWCYTQnWj695U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JqLpHGjz8FBfsB+oiUFw3oGbHf8VhZlWw288yxsMYis=;
        b=pNHYIcQ6S9IPwdXEjvXOwJxlPkYaTZ0AiVFhZw7p+SmHzZZSgy3ega+pDdUdPvyCps
         70Gdkbgd05/jEpWjl5tLVXlAgJs0XOZdHbBY3eNCXX/Zh6wcMCeSZ9HZFD95BzAuP603
         2GNgImV0J1RB5NyAoMLs3/nLn/QuU+2Fmzsycd4RH2vdbsVxeYuGyQMWey2vZ7PSFVzH
         dfvUXC6C4YcNHijhf2gS1iamgBV2JsdXAXdGMDyYC5t2gFMci4OBqaeGjCkqJRTIb3EH
         Je/CPg9PHbnYZcaT3jCyhtxToZGMa8rI+ASXuPVYto8dTrMuM1WCqvmI6yH8Lt97v6wD
         7wZw==
X-Gm-Message-State: AOAM533DhANxowd922KcTaUq7V4WcInO9DZXWHagfb3ERyAg19bv7F+r
        p5iyLkgKqB8pjyZMCmZr5A9X4/m210RAjfEq
X-Google-Smtp-Source: ABdhPJyAryAjPDXkZXsQsUWd46NKaQws1o6uq6J4S2nBgODpANu/ApFmXow+ZgrMboK9dZ2nfMcvpQ==
X-Received: by 2002:a05:620a:15c:: with SMTP id e28mr1338013qkn.311.1618452489517;
        Wed, 14 Apr 2021 19:08:09 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id q17sm800305qtp.45.2021.04.14.19.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:08:08 -0700 (PDT)
Message-ID: <07f5e30a2af1674f0a2f8995641bbaaf64e47d34.camel@kepstin.ca>
Subject: Re: [PATCH] Fix turbostat exiting with an error when run on AMD CPUs
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Linux PM list <linux-pm@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>
Date:   Wed, 14 Apr 2021 22:08:07 -0400
In-Reply-To: <88d11c19e662f67ae492eb4b93e12e1b24e68c1d.camel@kepstin.ca>
References: <88d11c19e662f67ae492eb4b93e12e1b24e68c1d.camel@kepstin.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2021-04-14 at 22:05 -0400, Calvin Walton wrote:
> The current version of turbostat exits immediately upon entering the
> main loop, with error code -13. This is a regression that was
> introducted
> in these commits:
> 
> 9972d5d84d76 tools/power turbostat: Enable accumulate RAPL display
> 87e15da95775 tools/power turbostat: Introduce functions to accumulate
> RAPL consumption

Ah, I failed to check the mailing list before sending this patch! Terry
Bowman's fix here should probably be preferred:
https://patchwork.kernel.org/project/linux-pm/patch/20210331155807.3838-1-terry.bowman@amd.com/

My patch was simply the minimum necessary to get turbostat working
again.
-- 
Calvin Walton <calvin.walton@kepstin.ca>

