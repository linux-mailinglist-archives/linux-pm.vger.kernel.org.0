Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54158E33
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 00:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfF0W5S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 18:57:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36184 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfF0W5S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 18:57:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id w7so2844375oic.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scI9xH5QTIptTJudFoOALtkbeV4cljG3jybWqqwH29M=;
        b=lzNeIxjhGX5LiRIdNnCz242+TWgFtnYUcwfRc66LhW+zqc2cWbPYRyv9JLV7LLz2L8
         a7GMdfELV4pXkrVqRQ20l7nuoIr4S+GFQaHtfw9glxPJ9RWhI0W4G9FBPo8mlqQk3wqu
         u5mZVfHTVbUokMdQZLqAqeNklj9ZNOcj613+6njKSKX0pBADLToDIKB+gq/8p02uUt/7
         ouv8vDuhLw17mG4tjvvRhIZ3jXZPNc3aePVsSLW218VBzp4hwt/YjwRajPd/t3ySeryo
         NnmwR9zT6JwqTGZRGcdpgSSQP9/8FDI2ci5AlXXucZb8CGXA+4MoHBNPVgnMbVRNdwfd
         T9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scI9xH5QTIptTJudFoOALtkbeV4cljG3jybWqqwH29M=;
        b=TZRNNxFOuTWEEvAjnDx9md0NIalFjQtXc7jHHz4AoTA1xWYvo5Eu7Ja5+EYvpX4oi/
         G9PAiDY8lHbwKXhA5S1d+n/rKxptsaF6F6Qr2rtwQQYlnIVFk75JBLfzAszzo8fEwPnw
         pSui3u4XJ/F13fctU+MS4kCQT1TcO5yvLx/kB4iiYgSBJZSkh58aRa+MPaL463OcO5K5
         9Vzu+yB+yTXJ3etC7a6mmNY/odgUqwg333KIQvPVFJS+sC21uuitVkuAXI9QU3UuXMVo
         g5YGPFhHIsyZ8yf7I1e2X4RcKb2wSQHEqieNMdOxt3KpnvIVhxYK+4bnywjp8pTlzFDX
         FnCA==
X-Gm-Message-State: APjAAAUKFDu9DLhffFyEEHoScqhEawsBQkJKmD6N3grvd7XVUkB+UjBq
        46GGXiHxBQjbGGUsEzZnnH60kYEjYToIadG7uTzKqw==
X-Google-Smtp-Source: APXvYqyy2rBxOKQF++zFTIccWwiLuYTSQZp4Yq6Lngm6GFhvxmoRuZ+7vmMtS6tCXZo+fDx9Jp0Z36Kry44jWnNxlxQ=
X-Received: by 2002:aca:af55:: with SMTP id y82mr4917oie.172.1561676237533;
 Thu, 27 Jun 2019 15:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190626005449.225796-1-trong@android.com> <20190626011221.GB22454@kroah.com>
 <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
 <CANA+-vD+qBqENZrk_7KZzedbzGPMzHniHTE4sY93gnkzzBif6A@mail.gmail.com> <20190627000412.GA527@kroah.com>
In-Reply-To: <20190627000412.GA527@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Thu, 27 Jun 2019 15:57:06 -0700
Message-ID: <CANA+-vBOQM=XXQx93o4ZPs7yaWyyAeHPds1NQbo5zYGGqVitMg@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 26, 2019 at 5:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 26, 2019 at 03:48:58PM -0700, Tri Vo wrote:
> > On Tue, Jun 25, 2019 at 6:33 PM Tri Vo <trong@android.com> wrote:
> > >
> > > On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jun 25, 2019 at 05:54:49PM -0700, Tri Vo wrote:
> > > > > Embedding a struct kobject into struct wakeup_source changes lifetime
> > > > > requirements on the latter. To that end, change deallocation of struct
> > > > > wakeup_source using kfree to kobject_put().
> > > >
> > > > Ick, are you sure you need a new kobject here?  Why wouldn't a named
> > > > attribute group work instead?  That should keep this patch much smaller
> > > > and simpler.
> > >
> > > Yeah, named attribute groups might be a much cleaner way to do this.
> > > Let me investigate.
> >
> > Say, we read /sys/power/wakeup_sources/foo/active_count.
>
> What is "foo" here?  You didn't include Documentation of the sysfs
> files so it was pretty impossible to say what exactly your heirachy was
> going to be in order to determine this :)

Sorry about that. I sent out a new version of the patch with updated
documentation.
