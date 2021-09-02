Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0023FE6A9
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 02:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbhIBA1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 20:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhIBA1K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 20:27:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF5C061575
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 17:26:13 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k65so355955yba.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CptstpGZORRU3IsYIloJqbWhHikn1ckNwph+iIdtJfc=;
        b=KJjMgyWgDPZNVmsiSfXPstCqx7Cv6leimA38DXhaRdLHgyAnsFQrjHt5ji8iOVTbaA
         K/+uGl//sF7mIvLXtsuE92k6eG5U+dy3GZ+oVW5XzrjScobDwvvsiSrtBO9GXNkewxjN
         Wb4kAJ1sQkkdxizNHuKxTPyi0oh7Ccc+XWqK44z7O7FrhKmQrhHa6y/+XZxEWgi71gLK
         LFPjnoZfSqrcj5rPjIszQqV6/+V975nET3m3NtDKJeGpVm2ZfhjlPazmkz5SxlSwwBBy
         pLV1HyflZQcD1QY6xA9bQAplBzgYykH1koRMFXZHxiYlYOREMG2We6WDhMRhloCJDn4Y
         6EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CptstpGZORRU3IsYIloJqbWhHikn1ckNwph+iIdtJfc=;
        b=idrwcimJ4MD6DAdBbdtjBMyiEYUaB2oDaLwXWZ/y3HtaQPlxjJ7o2VGTSdNj80tZsf
         WbR61gs9RR61jBkjlS/BVKciK/T6RrexJljfH23rhI+j16W5gMw5rHm2jFMPDJC6IeJE
         DXVzU9ugX3uobiqtaRy9deRF7YWvQ5WhlcRlVT/UlVUYx7VGjPvPsMyT/nyFF6AMd7zn
         nDYOi07LHd4PZkBua5SB4bqClqOlyjA6hv71j5S0jcIjVTTkVc7vLa7NBR1MCHtsUZDZ
         SdBdjShlYuUlPxX8v33KznsDhh90zC8HdgwHyAWS4AUBgOtLiqbR5fPvXKFKxs/9Klxi
         d9IQ==
X-Gm-Message-State: AOAM5320OBfYp5t1MfcZfWInmIgGv+rz0ZziHZU8y9YshOjBJPWGjQMH
        8uKwLcdfu8KENXwuszYAygrLODaW5xnw46wT73nUEg==
X-Google-Smtp-Source: ABdhPJw0MkZntzwLYBweF0Y7lXR0WTz8ODY0CF4jq3sidmXEVfKh7AZHfVBv/CowSJpHE/7wcb+BsIsyLaB/P+vFGA8=
X-Received: by 2002:a25:804:: with SMTP id 4mr733936ybi.346.1630542372170;
 Wed, 01 Sep 2021 17:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102125.624661-1-ulf.hansson@linaro.org>
 <CAGETcx868QWj0jMJ+U-eL62jT-LO_LTOw5EcwEKptfFOVa=A5A@mail.gmail.com>
 <CAPDyKFopTW=ZoB9FYJ-ozRZTnJDTT_gFtz0XDiU-weYb1Q9bkQ@mail.gmail.com>
 <CAGETcx_e7kCQ_0yC9=k1jzjJJEqdOMuA=JkD81=2-Nb4fcS0+w@mail.gmail.com>
 <CAPDyKFranX4Yz8546C1E3Gq_ZkQi34Xb=Rxi5mPtw-s_J1QPoQ@mail.gmail.com>
 <CAGETcx_DXQyaH2te1cxV+yCS+kdfjWOFbxQkhEKCbXtU0FWS1g@mail.gmail.com> <CAPDyKFpd1OCiSX-g4sJNjHhLs41AVzyE=O7gw7+YQ7RUOOk6rQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpd1OCiSX-g4sJNjHhLs41AVzyE=O7gw7+YQ7RUOOk6rQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 17:25:36 -0700
Message-ID: <CAGETcx8MPy-4v2KFtZ6vrrtnkd07gsL3iEKjQjyLL8i2fYycqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: property: fw_devlink: Rename 'node_not_dev' to 'optional_con_dev'
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 1, 2021 at 3:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 2 Sept 2021 at 00:06, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Sep 1, 2021 at 2:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 1 Sept 2021 at 22:56, Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Wed, Sep 1, 2021 at 12:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Tue, 31 Aug 2021 at 19:31, Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > >
> > > > > > > In the struct supplier_bindings the member 'node_not_dev' is described as
> > > > > > > "The consumer node containing the property is never a device.", but that
> > > > > > > doesn't match the behaviour of the code in of_link_property().
> > > > > > >
> > > > > > > To make the behaviour consistent with the description, let's rename the
> > > > > > > member to "optional_con_dev" and clarify the corresponding comment.
> > > > > > >
> > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/of/property.c | 9 +++++----
> > > > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > > index 6c028632f425..2babb1807228 100644
> > > > > > > --- a/drivers/of/property.c
> > > > > > > +++ b/drivers/of/property.c
> > > > > > > @@ -1249,7 +1249,8 @@ static struct device_node *parse_##fname(struct device_node *np,       \
> > > > > > >   * @parse_prop.index: For properties holding a list of phandles, this is the
> > > > > > >   *                   index into the list
> > > > > > >   * @optional: Describes whether a supplier is mandatory or not
> > > > > > > - * @node_not_dev: The consumer node containing the property is never a device.
> > > > > > > + * @optional_con_dev: The consumer node containing the property may not be a
> > > > > > > + *                   device, then try finding one from an ancestor node.
> > > > > >
> > > > > > Nak. This flag is not about "may not be". This is explicitly for
> > > > > > "never a device". It has to do with stuff like remote-endpoint which
> > > > > > is never listed under the root node of the device node. Your
> > > > > > documentation change is changing the meaning of the flag.
> > > > >
> > > > > Okay, fair enough.
> > > > >
> > > > > Although, as stated in the commit message this isn't the way code
> > > > > behaves. Shouldn't we at least make the behaviour consistent with the
> > > > > description of the 'node_not_dev' flag?
> > > >
> > > > I know what you mean, but if you use the flag correctly (where the
> > > > phandle pointed to will never be a device with compatible property),
> > > > the existing code would work correctly. And since the flag is relevant
> > > > only in this file, it's easy to keep it correct. I'd just leave it as
> > > > is.
> > >
> > > Sorry, but that just sounds lazy to me, I am sure we can do better.
> > > The current code and the name of the flag is confusing, at least to me
> > > (and I bet to others as well).
> > >
> > > Moreover, I don't quite understand your objections to changing this.
> > > Why leave this to be inconsistent when it can be easily fixed?
> >
> > If you feel so strong about it, go for it. No strong objections. Just
> > double check the refcounts are done correctly.
>
> The refcounts should be okay, I think.
>
> I am fine with either of the two suggestions I have made.

The one I Nak-ed earlier is not okay. So I think we have only one other option.

> But another
> option could be to come up with an alternative name (and a
> description) for the flag, instead of "optional_con_dev", if you
> perhaps have a better suggestion?

It's not fully clear to me what part of node_not_dev is confusing, but
I'll take a stab at it. How about:
- * @node_not_dev: The consumer node containing the property is never a device.
+ * @con_node_never_dev: The consumer node containing the property is never
+ *                     converted to a struct device. The struct device will be
+ *                     created for one of the ancestor nodes, which fw_devlink
+ *                     assumes would an ancestor with the compatible property.

If you are happy with this, then go ahead and use this name/comment
with the last code suggestion you made and send out a patch?

Thanks,
Saravana
