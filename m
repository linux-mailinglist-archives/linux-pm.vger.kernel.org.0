Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018211C0E7D
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 09:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEAHK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgEAHK6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 03:10:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B44C035494
        for <linux-pm@vger.kernel.org>; Fri,  1 May 2020 00:10:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so5061562wmj.1
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2020 00:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mBDKT+ktCzLDz5vnqGIMPVYMqA+dLaNnoHmBZSrKw/8=;
        b=InJ8A973y8+8kszwtscgsjofON42EsGmBGvB5rdSChLkuDVWLo1RzKF84S08gU00Jg
         b/hF5sDxLIN38sLUTcoQsTi+k/3F0o7sUgYjJn0qdPFnEeCJ76BXtth9dUJ11saS11et
         S3dJ2tQnkgNhWtdU8bbYFLzCszdBZ4SzM0B2laSzefTnoKdRG6q3sNcuKXuhUxWfXY5l
         21rRMFT7J6eo6Bo0vztzWLWO4WWRaDaNkNMlHz8DqMeksLexA+ysQQ7PdFh49RN6kKfJ
         CWBRs8JdaJO+QQc76z0EeclxhMVrNTeMdWTyU3zf5TpqXbEs9zoKyNPFb1G8ycRlz4hD
         lg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBDKT+ktCzLDz5vnqGIMPVYMqA+dLaNnoHmBZSrKw/8=;
        b=fLkfMNhNyWw+kVlKDPCBjSOJ1vYyz7KXuN3u/mdZplQXM03bjEiFSJYNgJd/A6ypFs
         qaZsopM2t2cFHTvEUfWA5jg90py4+emW/TDBuOmmen85bJY8GAAfK5vS/oas0Xzqyl6g
         66wTWL79SAOFgHVUzGIWNF8u7j/uqK+o03ktvzpWYAZHf29bK5ikfwDBvmlYU6ZwTSZM
         2idgTllnU+qisdVndIUOvkOfWoBhNKtFKu20u4yuwIctQ3GXAy6S8N6KTwhzfx081lZm
         VBDn5UeQ8O9PFsAnfnokTZPnjBUlJyAsMU1yEYmXRU6bYvlkdeX7fGasy+DXE8lmTa5X
         LpRQ==
X-Gm-Message-State: AGi0PuaICz0lwucMa+cl83tkBVnsirznsVGcJGKYs86t8//SXLsTeM96
        oRY6O+qF0zCjmvrN+6trzYF8O+oq0Ss=
X-Google-Smtp-Source: APiQypIKg/LzlTi9QslKbCVOI27uP1tHATUekWZaM7mN987LCqGDa26gdacbCDR+ZxPhkFHZ1kfy4Q==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr2769008wmg.114.1588317056678;
        Fri, 01 May 2020 00:10:56 -0700 (PDT)
Received: from dumbo ([2001:1b60:3:221:4134:101:0:1])
        by smtp.gmail.com with ESMTPSA id n6sm3279986wrs.81.2020.05.01.00.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:10:55 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jUPoy-0007o4-EL; Fri, 01 May 2020 09:10:52 +0200
Date:   Fri, 1 May 2020 09:10:52 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] uswsusp: build only when configured
Message-ID: <20200501071052.GA20585@dumbo>
References: <20200413190843.044112674@gmail.com>
 <20200413193718.956985775@gmail.com>
 <4068729.AMvo8hvaBI@kreacher>
 <20200427094840.GA29259@dumbo>
 <CAJZ5v0hbE3Gswp_Wp4QQTb8wuaAOGQrWNEa7Utg45wR50QN0QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hbE3Gswp_Wp4QQTb8wuaAOGQrWNEa7Utg45wR50QN0QQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 01:20:53PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 27, 2020 at 11:48 AM Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> >
> > On Sun, Apr 26, 2020 at 06:16:29PM +0200, Rafael J. Wysocki wrote:
> > >

[...]

> > >
> > > It is possible in theory that two processes write "disk" to /sys/power/state
> > > concurrently.
> > >
> > > Is there enough mutual exclusion in place to handle this gracefully after the
> > > above change?
> >
> > No, indeed.
> >
> > It looks like hibernate.c needs the mutual exclusion and user.c could
> > just use it. Should I move snapshot_device_available to hibernate.c
> > and rename it hibernate_available?
> 
> There is hibernation_available() already.
> 
> Maybe switch over to the refcount_t API, call the variable
> hibernate_refcount and use refcount_add_not_zero() on it for the
> mutual exclusion.

I'm doing as you ask but I'm not understanding what we actually gain
from using the refcount_t API.

I'm reading about relaxation of memory ordering and there is no mention
on what this implies for the add_not_zero operation that we use.

Honestly I would stick with the atomic_t, we just need the mutual
exclusion and no saturation semantics.

Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
