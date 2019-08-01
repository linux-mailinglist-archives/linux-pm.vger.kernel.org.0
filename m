Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61AE7E53A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 00:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfHAWL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 18:11:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43239 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbfHAWL7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 18:11:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so34851813pfg.10
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=ODIRyiL2jtm5+/15idQHr4S7cTy4XyQupt2hfbfu6pE=;
        b=HrCl0x5QBEnYD9qwWOywZJP+pIVZLFd/RMfSyMarPnYV6bB5gkfq4UstgZv/I6KWre
         WrZqFHlGrgGS2NpJ3Zkh0adwD9LjZiHgqs7DmVbDJd2cBJ7k/9zsOKFRqwx6DsIpGGPa
         DRexuLZIGD8yWzRNR69KPmmdZWa7pRQnY8bWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=ODIRyiL2jtm5+/15idQHr4S7cTy4XyQupt2hfbfu6pE=;
        b=LC07VNUeKRbBnVCRDXKnQXBk0FigXKXa+DaWzwZkiNBSuqKJRhgxSqM1chAFmv7117
         g+CV2aHVvtctfL59qy5Glj6MI/Z7jlEtqPFc9H+/9LxsnDpzKpJl4rZDW/tUOl+S7MLF
         e/MRFX2domOAWibmR5yR7Oqc4oEBYxNZfabk+qcdK4jJdfr1Q7nI7lGCfsDlTRTsEAgR
         rT+cJFNgoLo11MLpxmktR3yW8Gu4I8XSkwi9fVGj1JGdjA6k7BilqsDdPkYD/VDLZcIx
         4074JUFNXesMnV7/u1My/q1cFhtvkN94SLOEmFeCKIiNV8ezoRyYZ4CnwXSA+PR2GCQX
         S/wg==
X-Gm-Message-State: APjAAAU8nMzSJ5qxKehbKzyhcgmgDTOjjEWU25ekW4hMvgGU5fQEef4+
        fDFwn+CxvrKeASTjCYH4r81mqg==
X-Google-Smtp-Source: APXvYqzUKogwUrnGchxyuNQspz6IllekXTdbX1rD7q4rhhL1SC2V1i+o0c6K8ExVK774XbpjyozXyQ==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr959761pjj.13.1564697518491;
        Thu, 01 Aug 2019 15:11:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e5sm2796523pgt.91.2019.08.01.15.11.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:11:58 -0700 (PDT)
Message-ID: <5d4363ae.1c69fb81.b621e.65ed@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher> <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com> <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
To:     Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 15:11:57 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-01 14:44:52)
> On Thu, Aug 1, 2019 at 1:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> >
> > I don't find it awkward or difficult. Just know what the name of the
> > /sys/class/wakeup/ path is and then extract the name from there if it
> > doesn't match wakeupN, otherwise read the 'device' symlink and run it
> > through basename.
>=20
> The concern was that having both "id" and "name" around might be
> confusing. I don't think that making the presence of "name"
> conditional helps here. And we have to maintain additional logic in
> both kernel and userspace to support this.
>=20
> Also, say, userspace grabs a wakelock named "wakeup0". In the current
> patch, this results in a name collision and an error. Even assuming
> that userspace doesn't have ill intent, it still needs to be aware of
> "wakeupN" naming pattern to avoid this error condition.
>=20
> All wakeup sources in the /sys/class/wakeup/ are in the same namespace
> regardless of where they originate from, i.e. we have to either (1)
> inspect the name of a wakeup source and make sure it's unique before
> using it as a directory name OR (2) generate the directory name on
> behalf of whomever is registering a wakeup source, which I think is a
> much simpler solution.

Ok. If the device name is going to be something generic like 'wakeupN',
then we need to make sure that the wakeup source name is unique.
Otherwise, I'm not able to see how userspace will differentiate between
two of the same named wakelocks. Before this patch the wakeup source
name looks to have been used for debugging, but now it's being used
programmatically to let userspace act upon it somehow. Maybe it's for
debug still, but I could see how userspace may want to hunt down the
wakelock that's created in userspace and penalize or kill the task
that's waking up the device.

I see that wakelock_lookup_add() already checks the list of wakelock
wakeup sources, but I don't see how I can't create an "alarmtimer"
wakelock again, but this time for userspace, by writing into
/sys/power/wake_lock.

What happens with namespaces here BTW? Can a wakelock be made in one
namespace and that is the same name as another wakelock in a different
namespace? Right now it doesn't look possible because of the global name
matching, but it probably makes sense to support this? Maybe we just
shouldn't make anything in sysfs for wake sources that can be any random
name created from the wakelock path right now. I don't see how it can be
traced back to the process that created it in any reasonable way.

